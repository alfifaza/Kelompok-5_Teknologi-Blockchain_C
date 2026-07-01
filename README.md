# Blockchain-Based Medical Record System
Sistem rekam medis terdesentralisasi menggunakan Ethereum Smart Contract dan IPFS untuk menjamin integritas serta privasi data pasien

## LINK WEB RME DEPLOY VIA VERCEL
https://kelompok-5-teknologi-blockchain-c.vercel.app
- Harus add extension Metamask (Harus ada 2 role Wallet DOKTER dan PASIEN)
- Saldo Metamask (Sepolia ETH) cukup (bisa top-up di Sepolia Faucet)

## PENJELASAN
- DIAGRAM RME (kumpulan diagram flowchart, class diagram, dst.)
- MEDICHAIN RME WEB (kumpulan codingan web MEDICHAIN)
- SMART CONTRACT (file dari Remix IDE ada RME.sol dan contractABI.js)
- UAS (file laporan UAS, project charter, ppt)
- UTS (file laporan UTS, project charter, ppt)

## Tech Stack
- Blockchain: Ethereum (Solidity)
- Penyimpanan: IPFS
- Development Framework: Remix IDE
- Frontend: React.js

## Alur Sistem
- Upload: Data medis diunggah ke IPFS -> Mendapatkan CID
- Record: CID disimpan ke Smart Contract melalui fungsi addMedicalRecord()
- Access: Pasien memberikan izin akses ke alamat wallet dokter melalui fungsi grantAccess()
- View: Dokter melakukan query data melalui fungsi getRecords()

## -- Kelompok 5 - Teknologi Blockchain Kelas C -- 
