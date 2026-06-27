// SPDX-License-Identifier: MIT 

pragma solidity ^0.8.19; 

 

contract RMETerdesentralisasi { 

 

    // ========== ENUMS & STRUCTS ========== 

     

    enum Role { None, Patient, Doctor, Admin } 

 

    struct User { 

        string fullName;   // NAMA LENGKAP (baru) 

        string idNumber;   // NIK atau SIP 

        Role role; 

        bool isRegistered; 

    } 

 

    struct MedicalRecord { 

        string ipfsCID; 

        bytes32 sha256Hash; 

        address doctor; 

        address patient; 

        uint256 timestamp; 

    } 

 

    // ========== STATE VARIABLES ========== 

 

    mapping(address => User) public users; 

    mapping(address => MedicalRecord[]) private patientRecords; 

    mapping(address => mapping(address => bool)) private accessPermissions; 

    mapping(address => address[]) private authorizedDoctors; 

 

    // ========== EVENTS ========== 

 

    event UserRegistered(address indexed user, string fullName, Role role, uint256 timestamp); 

    event AccessGranted(address indexed patient, address indexed doctor, uint256 timestamp); 

    event AccessRevoked(address indexed patient, address indexed doctor, uint256 timestamp); 

    event RecordAdded(address indexed patient, address indexed doctor, string ipfsCID, uint256 timestamp); 

 

    // ========== MODIFIERS ========== 

 

    modifier onlyRegistered() { 

        require(users[msg.sender].isRegistered, "Anda belum terdaftar"); 

        _; 

    } 

 

    modifier onlyDoctor() { 

        require(users[msg.sender].role == Role.Doctor, "Hanya dokter yang bisa melakukan ini"); 

        _; 

    } 

 

    modifier onlyPatient() { 

        require(users[msg.sender].role == Role.Patient, "Hanya pasien yang bisa melakukan ini"); 

        _; 

    } 

 

    modifier hasAccess(address patient) { 

        require( 

            accessPermissions[patient][msg.sender] || msg.sender == patient, 

            "Anda tidak memiliki izin akses" 

        ); 

        _; 

    } 

 

    // ========== FUNGSI REGISTRASI ========== 

 

    function registerUser(string memory _fullName, string memory _idNumber, uint8 _role) public { 

        require(!users[msg.sender].isRegistered, "Sudah terdaftar"); 

        require(_role >= 1 && _role <= 3, "Role tidak valid"); 

        require(bytes(_fullName).length > 0, "Nama tidak boleh kosong"); 

 

        users[msg.sender] = User({ 

            fullName: _fullName, 

            idNumber: _idNumber, 

            role: Role(_role), 

            isRegistered: true 

        }); 

 

        emit UserRegistered(msg.sender, _fullName, Role(_role), block.timestamp); 

    } 

 

    function getUser(address _user) public view returns ( 

        string memory fullName, 

        string memory idNumber, 

        uint8 role, 

        bool isRegistered 

    ) { 

        User memory u = users[_user]; 

        return (u.fullName, u.idNumber, uint8(u.role), u.isRegistered); 

    } 

 

    // ========== FUNGSI IZIN AKSES ========== 

 

    function grantAccess(address _doctor) public onlyRegistered onlyPatient { 

        require(users[_doctor].role == Role.Doctor, "Alamat bukan dokter terdaftar"); 

        require(!accessPermissions[msg.sender][_doctor], "Akses sudah diberikan"); 

 

        accessPermissions[msg.sender][_doctor] = true; 

        authorizedDoctors[msg.sender].push(_doctor); 

 

        emit AccessGranted(msg.sender, _doctor, block.timestamp); 

    } 

 

    function revokeAccess(address _doctor) public onlyRegistered onlyPatient { 

        require(accessPermissions[msg.sender][_doctor], "Akses tidak ada"); 

 

        accessPermissions[msg.sender][_doctor] = false; 

 

        address[] storage doctors = authorizedDoctors[msg.sender]; 

        for (uint i = 0; i < doctors.length; i++) { 

            if (doctors[i] == _doctor) { 

                doctors[i] = doctors[doctors.length - 1]; 

                doctors.pop(); 

                break; 

            } 

        } 

 

        emit AccessRevoked(msg.sender, _doctor, block.timestamp); 

    } 

 

    function checkAccess(address _patient, address _doctor) public view returns (bool) { 

        return accessPermissions[_patient][_doctor]; 

    } 

 

    function getAuthorizedDoctors(address _patient) public view returns (address[] memory) { 

        return authorizedDoctors[_patient]; 

    } 

 

    // ========== FUNGSI REKAM MEDIS ========== 

 

    function addMedicalRecord( 

        address _patient, 

        string memory _ipfsCID, 

        bytes32 _sha256Hash 

    ) public onlyRegistered onlyDoctor hasAccess(_patient) { 

        patientRecords[_patient].push(MedicalRecord({ 

            ipfsCID: _ipfsCID, 

            sha256Hash: _sha256Hash, 

            doctor: msg.sender, 

            patient: _patient, 

            timestamp: block.timestamp 

        })); 

 

        emit RecordAdded(_patient, msg.sender, _ipfsCID, block.timestamp); 

    } 

 

    function getRecords(address _patient) public view hasAccess(_patient) returns ( 

        string[] memory cids, 

        bytes32[] memory hashes, 

        address[] memory doctors, 

        uint256[] memory timestamps 

    ) { 

        MedicalRecord[] memory records = patientRecords[_patient]; 

        uint len = records.length; 

 

        cids = new string[](len); 

        hashes = new bytes32[](len); 

        doctors = new address[](len); 

        timestamps = new uint256[](len); 

 

        for (uint i = 0; i < len; i++) { 

            cids[i] = records[i].ipfsCID; 

            hashes[i] = records[i].sha256Hash; 

            doctors[i] = records[i].doctor; 

            timestamps[i] = records[i].timestamp; 

        } 

    } 

 

    function getRecordCount(address _patient) public view returns (uint256) { 

        return patientRecords[_patient].length; 

    } 

 

    // ========== FUNGSI VERIFIKASI INTEGRITAS ========== 

 

    function verifyIntegrity( 

        address _patient, 

        uint256 _recordIndex, 

        bytes32 _hashToVerify 

    ) public view hasAccess(_patient) returns (bool) { 

        require(_recordIndex < patientRecords[_patient].length, "Index tidak valid"); 

        return patientRecords[_patient][_recordIndex].sha256Hash == _hashToVerify; 

    } 

}
