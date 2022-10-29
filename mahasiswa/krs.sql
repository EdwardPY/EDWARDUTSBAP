-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 21 Okt 2022 pada 17.02
-- Versi server: 10.4.22-MariaDB
-- Versi PHP: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `krs`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `krs`
--

CREATE TABLE `krs` (
  `kode_krs` varchar(15) NOT NULL,
  `StudentID` varchar(20) NOT NULL,
  `kode_term` varchar(4) NOT NULL,
  `keterangan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `krs`
--

INSERT INTO `krs` (`kode_krs`, `StudentID`, `kode_term`, `keterangan`) VALUES
('100000001', '03081200034', '1212', ''),
('100000002', '03081200000', '1213', '');

-- --------------------------------------------------------

--
-- Struktur dari tabel `krs_detail`
--

CREATE TABLE `krs_detail` (
  `kode_krsdetail` varchar(15) NOT NULL,
  `kode_krs` varchar(15) NOT NULL,
  `kode_matakuliah` varchar(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `krs_detail`
--

INSERT INTO `krs_detail` (`kode_krsdetail`, `kode_krs`, `kode_matakuliah`) VALUES
('10000000101', '100000001', 'MK0001'),
('10000000102', '100000001', 'MK0003'),
('10000000201', '100000002', 'MK0002'),
('10000000202', '100000002', 'MK0001'),
('10000000301', '100000003', 'MK0002'),
('10000000302', '100000003', 'MK0001'),
('10000000401', '100000004', 'MK0002'),
('10000000402', '100000004', 'MK0001');

-- --------------------------------------------------------

--
-- Struktur dari tabel `mahasiswa`
--

CREATE TABLE `mahasiswa` (
  `StudentID` varchar(12) NOT NULL,
  `Nama` varchar(50) NOT NULL,
  `Jurusan` varchar(30) NOT NULL,
  `Tahun_masuk` varchar(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `mahasiswa`
--

INSERT INTO `mahasiswa` (`StudentID`, `Nama`, `Jurusan`, `Tahun_masuk`) VALUES
('03081200000', 'ASEP', 'SISTEM INFORMASI', '2020'),
('03081200034', 'Erick Daniswara', 'SISTEM INFORMASI', '2020');

-- --------------------------------------------------------

--
-- Struktur dari tabel `matakuliah`
--

CREATE TABLE `matakuliah` (
  `No` int(100) NOT NULL,
  `kode_matakuliah` varchar(6) NOT NULL,
  `nama_matakuliah` varchar(50) NOT NULL,
  `sks` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `matakuliah`
--

INSERT INTO `matakuliah` (`No`, `kode_matakuliah`, `nama_matakuliah`, `sks`) VALUES
(1, 'MK0001', 'BUSINESS APPLICATION PROGRAMMING', 4),
(2, 'MK0002', 'AUDIT DAN KONTROL SISTEM INFROMASI', 4),
(3, 'MK0003', 'DASAR MANAJEMEN KEUANGAN PERUSAHAAN', 3),
(4, 'MK0004', 'MANAJEMEN STRATEGIS PERUSAHAAN', 3),
(5, 'MK0005', 'ENTREPRISE INFORMATION SYSTEMS', 3),
(6, 'MK0006', 'DIGITAL MARKETING', 3);

-- --------------------------------------------------------

--
-- Struktur dari tabel `term`
--

CREATE TABLE `term` (
  `kode_term` varchar(4) NOT NULL,
  `tahun_ajar` varchar(4) NOT NULL,
  `semester` varchar(10) NOT NULL,
  `keterangan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `term`
--

INSERT INTO `term` (`kode_term`, `tahun_ajar`, `semester`, `keterangan`) VALUES
('1212', '2020', 'GANJIL', ''),
('1213', '2020', 'GENAP', '');

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `vjlhmhskrs`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `vjlhmhskrs` (
`StudentID` varchar(12)
,`Nama` varchar(50)
,`JLHKRS` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `vmatakuliahsks_mhs`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `vmatakuliahsks_mhs` (
`kode` varchar(6)
,`Nama` varchar(50)
,`sks` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `vmatakuliah_mhs`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `vmatakuliah_mhs` (
`kode` varchar(6)
,`Nama` varchar(50)
,`jumlah_mahasiswa` bigint(21)
);

-- --------------------------------------------------------

--
-- Struktur untuk view `vjlhmhskrs`
--
DROP TABLE IF EXISTS `vjlhmhskrs`;

CREATE ALGORITHM=UNDEFINED DEFINER=`rick2022@`@`localhost` SQL SECURITY DEFINER VIEW `vjlhmhskrs`  AS SELECT `mhs`.`StudentID` AS `StudentID`, `mhs`.`Nama` AS `Nama`, count(`StudentID`) AS `JLHKRS` FROM (`mahasiswa` `mhs` join `krs` on(`mhs`.`StudentID` = `StudentID`)) GROUP BY `mhs`.`StudentID`, `mhs`.`Nama` ;

-- --------------------------------------------------------

--
-- Struktur untuk view `vmatakuliahsks_mhs`
--
DROP TABLE IF EXISTS `vmatakuliahsks_mhs`;

CREATE ALGORITHM=UNDEFINED DEFINER=`rick2022@`@`localhost` SQL SECURITY DEFINER VIEW `vmatakuliahsks_mhs`  AS SELECT `matakuliah`.`kode_matakuliah` AS `kode`, `matakuliah`.`nama_matakuliah` AS `Nama`, `matakuliah`.`sks` AS `sks` FROM ((`matakuliah` left join `krs_detail` on(`matakuliah`.`kode_matakuliah` = `krs_detail`.`kode_matakuliah`)) left join `krs` on(`krs_detail`.`kode_krs` = `kode_krs`)) GROUP BY `matakuliah`.`kode_matakuliah`, `matakuliah`.`nama_matakuliah` ;

-- --------------------------------------------------------

--
-- Struktur untuk view `vmatakuliah_mhs`
--
DROP TABLE IF EXISTS `vmatakuliah_mhs`;

CREATE ALGORITHM=UNDEFINED DEFINER=`rick2022@`@`localhost` SQL SECURITY DEFINER VIEW `vmatakuliah_mhs`  AS SELECT `matakuliah`.`kode_matakuliah` AS `kode`, `matakuliah`.`nama_matakuliah` AS `Nama`, count(`mahasiswa`.`StudentID`) AS `jumlah_mahasiswa` FROM (((`matakuliah` left join `krs_detail` on(`matakuliah`.`kode_matakuliah` = `krs_detail`.`kode_matakuliah`)) left join `krs` on(`krs_detail`.`kode_krs` = `kode_krs`)) left join `mahasiswa` on(`StudentID` = `mahasiswa`.`StudentID`)) GROUP BY `matakuliah`.`kode_matakuliah`, `matakuliah`.`nama_matakuliah` ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `krs`
--
ALTER TABLE `krs`
  ADD PRIMARY KEY (`kode_krs`);

--
-- Indeks untuk tabel `krs_detail`
--
ALTER TABLE `krs_detail`
  ADD PRIMARY KEY (`kode_krsdetail`);

--
-- Indeks untuk tabel `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD PRIMARY KEY (`StudentID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
