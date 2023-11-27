# Bookify Mobile

## Anggota Kelompok 👥
1. Alif Bintang Elfandra 2206029153
2. Aulia Rizqi Hidayatunnisa 2206817881
3. Darrel Jeremiah Simanjuntak 2206829225
4. Eryanda Arian Ro'uuf 2206816090
5. Sita Amira Syarifah 2206023023
6. Zaki Baihaqi Harahap 2206031901

## Penjelasan Aplikasi 📱
Aplikasi yang kami ajukan berupa perpustakaan _online_ bernama Bookify. Bookify adalah sebuah aplikasi perpustakaan _online_ yang dirancang untuk membantu pengguna dalam mengeksplorasi, meminjam, dan membaca buku secara digital. Meningkatnya popularitas buku elektronik _(e-book)_ serta kemajuan teknologi internet telah mendorong kebutuhan akan platform perpustakaan _online_ yang memungkinkan pengguna untuk mengakses ratusan hingga ribuan buku dengan mudah. Bookify juga memanfaatkan kemajuan _gadget_ yang memungkinkan pengguna untuk membawa koleksi buku mereka dalam genggaman dimana dan kapan saja. Dengan menyediakan akses yang lebih mudah dan cepat ke berbagai sumber literatur, Bookify membantu memfasilitasi dan mendorong kegiatan membaca di seluruh dunia. Melalui inovasi ini, Bookify hadir berperan dalam meningkatkan aksesbilitas literatur dan memajukan budaya literasi di era digital. 

## Role User 🧑‍💻
### 1. Reguler
    - Dapat melihat buku yang ada di perpustakaan
    - Dapat melihat ulasan atau quotes dari buku oleh peminjam sebelumnya
    - Dapat request buku, jika buku yang ingin dibaca tidak ada di perpustakaan
    - Dapat mengulas buku yang telah dibaca
    - Dapat melihat ulasan atau quotes dari buku oleh peminjam sebelumnya
    - Dapat menanyakan pertanyaan untuk suatu buku
    - Dapat meminjam buku dengan jangka waktu lebih singkat dibanding member

### 2. Admin
    - Dapat mengakses data user
    - Dapat menambahkan Q&A (menjawab pertanyaan) untuk setiap buku

### 3. Tamu (Guest)
    - Dapat melihat tampilan perpustakaan secara umum (seperti scele saat belum login)
    - Dapat melihat buku yang ada di perpustakaan

## Daftar Modul📝
### 1. **HomePage** (seluruh anggota)
Pada halaman `homepage`, pengguna dapat melihat informasi mengenai website. Selain itu, halaman ini juga menampilkan modul yang dapat diakses, namun pengguna Guest tidak dapat mengakses semua fitur kecuali lihat buku
- About website

### 2. **Profil user** (Aulia Rizqi)
Pada halaman `profil user`, terdapat data-data mengenai pengguna dan role (Reguler atau Spesial) serta dapat menambahkan buku favorit.
- Ubah Profil (tanggal lahir dan deskripsi)
- Menambahkan buku favorit

### 3. **Halaman pinjam buku** (Sita Amira)
Pada halaman `pinjam buku`, user Reguler dan Spesial dapat melakukan peminjaman buku.
- Filter berdasarkan tahun terbit, judul, bahasa buku
- Meminjam buku

### 4. **Halaman baca dan wishlist** (Zaki Baihaqi)
Pada halaman `baca dan wishlist`, user Reguler dan Spesial dapat melihat daftar buku wishlist dan menambahkan.
- Melihat wishlist

### 5. **Halaman request buku** (Darrel Jeremiah)
Pada halaman `request buku`, user Reguler dan Spesial dapat merequest buku yang belum tersedia di perpustakaan.
- Request buku yang belum tersedia di perpustakaan

### 6. **Halaman ulasan buku** (Eryanda Arian)
Pada halaman `ulasan buku`, user Reguler dan Spesial dapat memberikan ulasan buku yang sudah pernah dipinjam.
- Ulasan buku

### 7. **FAQ** (Alif Bintang)
Halaman `FAQ` ini berisi daftar pertanyaan beserta jawaban untuk masing-masing buku. 
- Sebagai user Reguler/Spesial, user dapat mengirimkan pertanyaan untuk suatu buku melalui form yang tersedia (tetapi belum akan ditampilkan sampai Admin menjawab). 
- Admin dapat melihat kumpulan pertanyaan untuk suatu buku, kemudian dapat memilih pertanyaan mana yang akan dijawab/dihapus. Ketika pertanyaan sudah dijawab, pertanyaan dan jawaban tersebut akan ditampilkan. 
- Baik Admin dan User Reguler/Spesial dapat melihat apa saja pertanyaan dan jawaban untuk setiap buku, tapi jika pertanyaannya belum dijawab, hanya Admin yang dapat melihat kumpulan pertanyaan yang dikirim oleh User Non-Admin tersebut.

## Alur Integrasi
Website yang telah terlebih dahulu dideploy disusun memiliki backend yang dapat menampilkan JSON data-data terkait
Membuat file bernama fetch.dart dalam utils folder untuk melakukan proses async mengambil data
fetch.dart dilengkapi dengan suatu fungsi yang dapat dipanggil dari luar file kemudian melakukan return data dalam suatu list
Fungsi di dalam fetch.dart mengandung url yang digunakan sebagai endpoint JSON
Pemanggilan fungsi dilakukan di widget terkait untuk diolah sesuai dengan kebutuhan

## Berita Acara
https://docs.google.com/spreadsheets/d/1lJv1dRvzTASb-BjoKw-3O13HaaSMznwwoi2R_66eM7g/edit?usp=drivesdk



