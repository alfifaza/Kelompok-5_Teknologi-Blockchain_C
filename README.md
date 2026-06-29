Blockchain-Based Medical Record System
Sistem rekam medis terdesentralisasi yang mengintegrasikan teknologi blockchain dan IPFS untuk menjamin integritas, privasi, dan transparansi data kesehatan pasien. Proyek ini dikembangkan untuk memitigasi risiko manipulasi data medis serta memberikan kendali penuh kepada pasien atas hak akses rekam medis mereka.

🚀 Fitur Utama
Penyimpanan Hybrid: Memanfaatkan IPFS untuk penyimpanan dokumen medis secara off-chain dan blockchain untuk penyimpanan metadata serta hash guna memastikan integritas data.

Kendali Akses Terdesentralisasi: Pasien memiliki otoritas penuh untuk memberikan atau mencabut izin akses rekam medis kepada tenaga medis melalui smart contract.

Transparansi & Immutability: Setiap aktivitas akses dan perubahan data tercatat secara permanen di ledger, mencegah intervensi pihak ketiga yang tidak sah.

Efisiensi Biaya: Optimalisasi gas fee melalui pendekatan arsitektur hybrid yang efisien.

🛠️ Teknologi yang Digunakan
Blockchain: Ethereum (Smart Contract)

Penyimpanan: IPFS (InterPlanetary File System)

Bahasa Pemrograman: Solidity

Framework/Tools: [Sebutkan tools Anda, contoh: Hardhat, Truffle, Web3.js]

Frontend: [Sebutkan tech stack frontend, contoh: React.js, Next.js]

📋 Struktur Proyek
Plaintext
├── contracts/          # File smart contract Solidity
├── migrations/         # Skrip deployment
├── test/               # Skrip pengujian sistem
├── src/                # Kode sumber aplikasi frontend
├── ipfs/               # Konfigurasi integrasi IPFS
└── README.md
⚙️ Instalasi & Menjalankan Sistem
Clone repositori:

Bash
git clone https://github.com/alfifaza/Kelompok-5_Teknologi-Blockchain_C.git
cd Kelompok-5_Teknologi-Blockchain_C
Instal dependensi:

Bash
npm install
Deploy Smart Contract:

Bash
npx hardhat run scripts/deploy.js --network <nama-network>
Jalankan aplikasi:

Bash
npm start
📝 Kontributor
Proyek ini dikembangkan oleh Kelompok 5 - Teknologi Blockchain Kelas C
