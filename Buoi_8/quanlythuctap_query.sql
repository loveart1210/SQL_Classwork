USE quanlythuctap_1;
SELECT * FROM Sv;
SELECT * FROM Dt;

-- 1. Hiển thị sinh viên có mã 01
CALL sp_hien_sv_01();

-- 2. Hiển thị sinh viên quê TPHCM và học lực >= 8
CALL sp_hien_tp_8();

-- 3. Hiển thị sinh viên theo quê quán truyền vào
CALL sp_hien_sv_que('Long An');

-- 4. Thêm sinh viên (3 cách)
DELETE FROM Sv WHERE sv = '10';
CALL sp_them_sv_khongkt();
CALL sp_them_sv_kt_khoa();
DELETE FROM Sv WHERE sv = '10';
CALL sp_them_sv_kt_hl();

-- 5. Cộng thêm 0.5 điểm học lực cho sinh viên quê ở Bình Phước
CALL sp_tang_hl_bp();
SELECT * FROM Sv WHERE que = 'Bình Phước';

-- 6. Đề tài có kinh phí cao nhất (OUT param)
SET @max_kp = 0;
CALL sp_dt_max_kp(@max_kp);
SELECT @max_kp AS 'Kinh phí cao nhất';

-- 7. Thêm Sd – kiểm tra rỗng
CALL sp_them_sd_kt_rong('', 'A01', '2025-10-10', 1000, 9);
CALL sp_them_sd_kt_rong('01', '', '2025-10-10', 1000, 9);

-- 8. Thêm Sd – kiểm tra tồn tại
CALL sp_them_sd_kt_tontai('01', 'A01', '2025-10-10', 1000, 9);
CALL sp_them_sd_kt_tontai('99', 'A01', '2025-10-10', 1000, 9);
CALL sp_them_sd_kt_tontai('01', 'B99', '2025-10-10', 1000, 9);

-- 9. Thêm đề tài và hiển thị đề tài có kinh phí lớn hơn
CALL sp_them_dt_va_hien('A10', 'AI Vision', 'CNTT', 1000);

-- 10. Hiển thị sinh viên thực tập kém nhất và đề tài của họ
CALL sp_sv_kem_nhat();

-- 11. Thêm dữ liệu Sd – nếu đề tài đã được chọn >4 lần thì không cho thêm
-- (Thêm 4 dòng cho cùng 1 đề tài để test)
DELETE FROM Sd WHERE sv='01' AND dt='A01';
INSERT INTO Sd VALUES ('01', 'A01', '2025-10-10', 1000, 9);

INSERT INTO Sd VALUES ('01', 'A01', '2025-10-10', 1000, 9);

INSERT INTO Sd VALUES ('02', 'A01', '2025-10-10', 1000, 9);
INSERT INTO Sd VALUES ('03', 'A01', '2025-10-10', 1000, 9);
INSERT INTO Sd VALUES ('04', 'A01', '2025-10-10', 1000, 9);
CALL sp_them_sd_gioihan('05', 'A01', '2025-10-10', 1000, 9); -- sẽ bị chặn