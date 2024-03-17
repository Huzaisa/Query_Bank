-- Active: 1710601348191@@127.0.0.1@5432@bank
CREATE DATABASE bank;

--create
CREATE TABLE nasabah(
    nasabah_id BIGSERIAL PRIMARY key,
    nama_nasabah VARCHAR(255) not null,
    alamat VARCHAR(255) not null,
    no_telpon VARCHAR(255) not null 
);

INSERT INTO nasabah (nama_nasabah, alamat, no_telpon) VALUES
('huzi', 'tangerang', '08380848'),
('julius', 'cibinong', '08123456789'),
('huzaisa', 'depok', '082345');


CREATE Table akun (
    akun_id BIGSERIAL PRIMARY key,
    saldo DECIMAL not null,
    email VARCHAR(255) not null,
    PASSWORD VARCHAR(255) not null,
    nasabah_id int,
    FOREIGN KEY (nasabah_id) REFERENCES nasabah(nasabah_id)
);

INSERT INTO akun(saldo,email,PASSWORD)values
('1000000','huzi@gmail.com','akuganteng'),
('1500000','julius@gmail.com','emanuel'),
('2000000','huzaisa@gmail.com','terakhir');

CREATE TABLE transaksi(
    transaksi_id BIGSERIAL PRIMARY key,
    tanggal date,
    jumlah DECIMAL,
    akun_id int,
    FOREIGN KEY (akun_id) REFERENCES akun(akun_id)
);

begin TRANSACTION;
INSERT into transaksi(tanggal,jumlah,akun_id) VALUES
('2024-03-04',10000,2),
('2024-04-03',20000,1),
('2024-01-01',5000,3);
COMMIT; --jika sudah benar
ROLLBACK; --jika terjadi kesalahan
end TRANSACTION;


SELECT * FROM transaksi;

--read
SELECT * FROM nasabah WHERE nasabah_id = 1;
SELECT * FROM transaksi;
SELECT * FROM akun WHERE akun_id = 3;
SELECT * FROM akun


--update
UPDATE akun SET nasabah_id = 3 WHERE akun_id = 3;
UPDATE akun SET nasabah_id = 2 WHERE akun_id = 2;
UPDATE akun SET nasabah_id = 1 WHERE akun_id = 1;

UPDATE Transaksi SET Jumlah = 600 WHERE Transaksi_ID = 4;

--join
SELECT nasabah.nasabah_id, nasabah.nama_nasabah, akun.akun_id, akun.saldo, transaksi.tanggal, transaksi.jumlah
FROM nasabah
LEFT JOIN akun ON nasabah.nasabah_id = akun.nasabah_id
LEFT JOIN transaksi ON akun.akun_id = transaksi.akun_id
ORDER BY nasabah.nasabah_id;


--delete
SELECT * FROM transaksi;
DELETE FROM transaksi WHERE transaksi_id = 6;
SELECT * FROM transaksi;

SELECT * FROM akun;
DELETE FROM akun WHERE akun_id = 3;
SELECT * FROM akun;

SELECT * FROM nasabah;
DELETE FROM nasabah WHERE nasabah_id = 3;
SELECT * FROM nasabah;

--note: untuk delete jika ada case violates foreign key constraint maka hapus dulu data yang FK, baru bisa didelete di table yang difk kan
--misalnya table transaksi ada fk akun_id, nah untuk bisa delete akun_id yang di akun, maka harus delete dulu yang di transaksi