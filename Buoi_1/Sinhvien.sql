-- CREATE DATABASE QLSV;
USE QLSV;

CREATE TABLE SV (
    MaSV VARCHAR(10) PRIMARY KEY,
    TenSV VARCHAR(50),
    QueQuan VARCHAR(50),
    GioiTinh VARCHAR(5),
    DiemTRR INT,
    DiemSQL INT,
    DiemLT INT
);

INSERT INTO SV VALUES
('A001', 'Nguyễn Chí Phèo', 'Hà Nam', 'Nam', 7, 6, 7),
('A002', 'Đỗ Thị Nở', 'Hà Nam', 'Nữ', 3, 6, 3),
('A003', 'Trần Văn Tèo', 'Hà Nội', 'Nam', 6, 8, 7),
('A004', 'Nguyễn Chí Hợi', 'Bắc Ninh', 'Nam', 7, 6, 3),
('A005', 'Nguyễn Thị Nụ', 'Hà Nội', 'Nữ', 8, 7, 7),
('A006', 'Nguyễn Văn Hậu', 'Lạng Sơn', 'Nam', 8, 7, 5),
('A007', 'Trần Trung Hậu', 'Bắc Giang', 'Nam', 5, 5, 5);

-- 1. Có bao nhiêu sinh viên, số sinh viên nam, nữ
SELECT COUNT(*) AS TongSV FROM SinhVien;
SELECT GioiTinh, COUNT(*) AS SoLuong FROM SinhVien GROUP BY GioiTinh;

-- 2. Có bao nhiêu sinh viên Họ Nguyễn, Tên đệm là "Thị"
SELECT COUNT(*) AS SoSV_HoNguyen
FROM SinhVien
WHERE TenSV LIKE 'Nguyễn%';

SELECT COUNT(*) AS SoSV_HoNguyen_Thi
FROM SinhVien
WHERE TenSV LIKE 'Nguyễn Thị%';

-- 3. Có bao nhiêu sinh viên Nam, mang họ Nguyễn và quê Hà Nam
SELECT COUNT(*) AS SoLuong
FROM SinhVien
WHERE GioiTinh = 'Nam'
  AND TenSV LIKE 'Nguyễn%'
  AND QueQuan = 'Hà Nam';

-- 4. Có bao nhiêu sinh viên không phải quê ở Hà Nam
SELECT COUNT(*) AS SoLuong
FROM SinhVien
WHERE QueQuan <> 'Hà Nam';

-- 5. Liệt kê sinh viên phải thi lại môn TRR, SQL, LT, ĐTB ((TRR+SQL+LT)/3) < 5
SELECT MaSV, TenSV, DiemTRR, DiemSQL, DiemLT,
       (DiemTRR + DiemSQL + DiemLT)/3 AS DiemTB
FROM SinhVien
WHERE DiemTRR < 5 OR DiemSQL < 5 OR DiemLT < 5
   OR (DiemTRR + DiemSQL + DiemLT)/3 < 5;

-- 6. Tìm sinh viên có điểm môn SQL cao nhất
SELECT *
FROM SinhVien
WHERE DiemSQL = (SELECT MAX(DiemSQL) FROM SinhVien);

-- 7. Tìm sinh viên có điểm trung bình cao nhất, thấp nhất
-- Điểm TB cao nhất
SELECT *
FROM SinhVien
WHERE (DiemTRR + DiemSQL + DiemLT)/3 = (
    SELECT MAX((DiemTRR + DiemSQL + DiemLT)/3) FROM SinhVien
);

-- Điểm TB thấp nhất
SELECT *
FROM SinhVien
WHERE (DiemTRR + DiemSQL + DiemLT)/3 = (
    SELECT MIN((DiemTRR + DiemSQL + DiemLT)/3) FROM SinhVien
);
