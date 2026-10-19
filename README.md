# Catat Laba (multi-toko, tanpa login)

Aplikasi statis (HTML biasa, tanpa build) + Supabase sebagai database. Isi file:

- `index.html` aplikasinya
- `config.js` tempat mengisi URL dan key Supabase
- `supabase.sql` pembuat tabel
- `vercel.json` pengaturan Vercel (hanya menambah header noindex)

## 1. Siapkan Supabase (project yang sudah ada)

1. Buka dashboard Supabase, pilih project existing kamu.
2. Menu **SQL Editor** > **New query**, tempel seluruh isi `supabase.sql`, klik **Run**.
   Ini hanya membuat 2 tabel baru: `pb_stores` dan `pb_transactions`. Tabel lain tidak disentuh.
3. Cek di **Table Editor**: dua tabel itu harus muncul.
4. Buka **Project Settings** > **API** (atau **API Keys**), salin:
   - **Project URL** (bentuknya `https://xxxx.supabase.co`)
   - **anon public key** (diawali `eyJ...`) atau **publishable key** (diawali `sb_publishable_...`). Dua-duanya bisa.
5. Buka `config.js`, ganti dua nilainya. Jangan pernah memakai `service_role` / secret key di sini.

## 2. Coba di komputer (opsional)

```
npx serve .
```
Buka alamat yang muncul. Pertama kali akan diminta membuat toko pertama.

## 3. Deploy ke Vercel

Lewat GitHub (paling mudah):
1. Taruh folder ini di repo GitHub.
2. Di vercel.com klik **Add New** > **Project**, pilih repo itu.
3. Framework Preset: **Other**. Build Command dan Output Directory dikosongkan. Klik **Deploy**.

Lewat CLI:
```
npm i -g vercel
vercel        # preview
vercel --prod # produksi
```

Setiap ubah `config.js` atau `index.html`, deploy ulang.

## 4. Cara pakai

- Dropdown paling atas berisi daftar toko. Pilih **+ Toko baru...** untuk menambah toko, tiap toko punya transaksi dan laporan sendiri.
- Ganti nama atau hapus toko ada di tab **Lainnya**.
- Tombol **+** menambah transaksi, ketuk baris transaksi untuk edit atau hapus.

## 5. Catatan keamanan (penting)

Karena tanpa login, URL dan key Supabase ikut terkirim ke browser, jadi siapa pun yang tahu alamat web kamu bisa melihat dan mengubah data semua toko. Untuk pemakaian pribadi atau tim kecil ini biasanya cukup kalau:

- alamat webnya tidak disebar (halaman sudah diberi noindex agar tidak muncul di Google),
- tidak ada data sensitif orang lain di dalamnya.

Kalau nanti butuh lebih aman, pilihannya: aktifkan Password Protection di Vercel (Settings > Deployment Protection, tergantung paket), atau tambahkan login Supabase Auth dan ganti policy RLS menjadi per-user.

Kalau project Supabase kamu dipakai aplikasi lain, tabel `pb_` ini terpisah, tapi key yang sama bisa mengakses tabel lain kalau RLS di tabel tersebut longgar. Cek RLS tabel lainmu.
