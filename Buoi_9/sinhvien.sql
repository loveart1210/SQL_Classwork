-- Tạo CSDL
CREATE DATABASE IF NOT EXISTS QuanLySinhVien;
USE QuanLySinhVien;

-- Tạo bảng SinhVien
CREATE TABLE SinhVien (
    MSSV CHAR(10) PRIMARY KEY,
    Lop VARCHAR(20),
    Ho VARCHAR(30),
    Ten VARCHAR(30),
    HoTen VARCHAR(60),
    NgaySinh DATE,
    GioiTinh VARCHAR(10)
);

-- Thêm dữ liệu vào bảng
INSERT INTO SinhVien (MSSV, Lop, HoTen, NgaySinh, GioiTinh) VALUES
('A01', 'K40SPT',  'Nguyen Van Chi',  '1993-12-01', 'Nam'),
('A02', 'K14CNTT', 'Tran Trong Pheo', '1995-03-05', 'Nam'),
('A03', 'K40SPT',  'Tran Van Binh',   '1994-12-24', 'Nam'),
('A04', 'K40SPT',  'Nguyen Thi No',   '1993-11-21', 'Nu'),
('A05', 'K14CNTT', 'Ho Thi Nga',      '1994-09-22', 'Nu');
