#Blockchain-Based Medical Record System
Sistem rekam medis terdesentralisasi menggunakan Ethereum Smart Contract dan IPFS untuk menjamin integritas serta privasi data pasien

# 'Tech Stack'
- Blockchain: Ethereum (Solidity)
- Penyimpanan: IPFS
- Development Framework: Hardhat
- Frontend: React.js / Web3.js

# 'Alur Sistem'
- Upload: Data medis diunggah ke IPFS -> Mendapatkan CID
- Record: CID disimpan ke Smart Contract melalui fungsi addMedicalRecord
- Access: Pasien memberikan izin akses ke alamat wallet dokter melalui fungsi giveAccess
- View: Dokter melakukan query data melalui fungsi getRecords

'-- Kelompok 5 - Teknologi Blockchain Kelas C --'
