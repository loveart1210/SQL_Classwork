DROP DATABASE IF EXISTS quanlythuctap_1;
CREATE DATABASE quanlythuctap_1;
USE quanlythuctap_1;

-- --------------------
-- 1. Tạo bảng
-- --------------------
CREATE TABLE Sv (
    sv VARCHAR(10) PRIMARY KEY,
    ht NVARCHAR(50),
    ns DATE,
    que NVARCHAR(50),
    hl FLOAT
);

CREATE TABLE Dt (
    dt VARCHAR(10) PRIMARY KEY,
    tdt NVARCHAR(50),
    cn NVARCHAR(50),
    kp FLOAT
);

CREATE TABLE Sd (
    sv VARCHAR(10),
    dt VARCHAR(10),
    ntt DATE,
    km FLOAT,
    kq FLOAT,
    PRIMARY KEY (sv, dt),
    FOREIGN KEY (sv) REFERENCES Sv(sv),
    FOREIGN KEY (dt) REFERENCES Dt(dt)
);

-- --------------------
-- 2. Stored Procedures
-- --------------------
DELIMITER //

-- 1. Hiển thị sinh viên mã 01
CREATE PROCEDURE sp_hien_sv_01()
BEGIN
    SELECT * FROM Sv WHERE sv = '01';
END //

-- 2. Hiển thị sinh viên quê TPHCM và học lực >=8
CREATE PROCEDURE sp_hien_tp_8()
BEGIN
    SELECT * FROM Sv WHERE que = 'TPHCM' AND hl >= 8;
END //

-- 3. Hiển thị sinh viên theo quê quán truyền vào
CREATE PROCEDURE sp_hien_sv_que(IN p_que NVARCHAR(50))
BEGIN
    SELECT * FROM Sv WHERE que = p_que;
END //

-- 4a. Thêm sinh viên không kiểm tra
CREATE PROCEDURE sp_them_sv_khongkt()
BEGIN
    INSERT INTO Sv VALUES ('10', 'Nguyễn Văn Tí', '1990-02-12', 'Long An', 10);
END //

-- 4b. Thêm sinh viên kiểm tra khóa chính
CREATE PROCEDURE sp_them_sv_kt_khoa()
BEGIN
    IF EXISTS (SELECT * FROM Sv WHERE sv = '10') THEN
        SELECT 'Mã sinh viên đã tồn tại!' AS ThongBao;
    ELSE
        INSERT INTO Sv VALUES ('10', 'Nguyễn Văn Tí', '1990-02-12', 'Long An', 10);
    END IF;
END //

-- 4c. Thêm sinh viên kiểm tra học lực
CREATE PROCEDURE sp_them_sv_kt_hl()
BEGIN
    DECLARE v_hl FLOAT DEFAULT 10;
    IF v_hl < 0 OR v_hl > 10 THEN
        SELECT 'Học lực không hợp lệ (0-10)!' AS ThongBao;
    ELSE
        INSERT INTO Sv VALUES ('10', 'Nguyễn Văn Tí', '1990-02-12', 'Long An', v_hl);
    END IF;
END //

-- 5. Cộng thêm 0.5 điểm học lực cho SV quê Bình Phước (tối đa 10)
CREATE PROCEDURE sp_tang_hl_bp()
BEGIN
    UPDATE Sv
    SET hl = CASE WHEN hl + 0.5 > 10 THEN 10 ELSE hl + 0.5 END
    WHERE que = 'Bình Phước';
END //

-- 6. Đề tài có kinh phí cao nhất (OUT param)
CREATE PROCEDURE sp_dt_max_kp(OUT p_max FLOAT)
BEGIN
    SELECT MAX(kp) INTO p_max FROM Dt;
    SELECT * FROM Dt WHERE kp = p_max;
END //

-- 7. Thêm SD, nếu sv hoặc dt bị rỗng thì không cho thêm
CREATE PROCEDURE sp_them_sd_kt_rong(
    IN p_sv VARCHAR(10),
    IN p_dt VARCHAR(10),
    IN p_ntt DATE,
    IN p_km FLOAT,
    IN p_kq FLOAT)
BEGIN
    IF p_sv = '' OR p_dt = '' THEN
        SELECT 'Mã sinh viên hoặc đề tài bị rỗng!' AS ThongBao;
    ELSE
        INSERT INTO Sd VALUES (p_sv, p_dt, p_ntt, p_km, p_kq);
    END IF;
END //

-- 8. Thêm SD, nếu sv hoặc dt không tồn tại trong Sv hoặc Dt thì không cho thêm
DROP PROCEDURE IF EXISTS sp_them_sd_kt_tontai;
CREATE PROCEDURE sp_them_sd_kt_tontai(
    IN p_sv VARCHAR(10),
    IN p_dt VARCHAR(10),
    IN p_ntt DATE,
    IN p_km FLOAT,
    IN p_kq FLOAT)
BEGIN
    IF NOT EXISTS (SELECT * FROM Sv WHERE sv = p_sv)
        OR NOT EXISTS (SELECT * FROM Dt WHERE dt = p_dt) THEN
        SELECT 'Sinh viên hoặc đề tài không tồn tại' AS ThongBao;

    ELSEIF EXISTS (SELECT * FROM Sd WHERE sv = p_sv AND dt = p_dt) THEN
        SELECT 'Dữ liệu (sv, dt) này đã tồn tại trong Sd!' AS ThongBao;

    ELSE
        INSERT INTO Sd VALUES (p_sv, p_dt, p_ntt, p_km, p_kq);
        SELECT 'Thêm dữ liệu vào Sd thành công!' AS ThongBao;
    END IF;
END //

-- 9. Thêm đề tài mới và hiển thị các đề tài có kinh phí lớn hơn
DROP PROCEDURE IF EXISTS sp_them_dt_va_hien;
CREATE PROCEDURE sp_them_dt_va_hien(
    IN p_dt VARCHAR(10),
    IN p_tdt NVARCHAR(50),
    IN p_cn NVARCHAR(50),
    IN p_kp FLOAT)
BEGIN
    -- Kiểm tra trùng mã đề tài
    IF EXISTS (SELECT 1 FROM Dt WHERE dt = p_dt) THEN
        SELECT CONCAT('⚠️ Mã đề tài ', p_dt, ' đã tồn tại!') AS ThongBao;
    
    ELSE
        -- Thêm mới
        INSERT INTO Dt(dt, tdt, cn, kp)
        VALUES (p_dt, p_tdt, p_cn, p_kp);
        
        -- Hiển thị các đề tài có kinh phí lớn hơn đề tài vừa thêm
        SELECT * FROM Dt WHERE kp > p_kp;
    END IF;
END //

-- 10. Hiển thị sinh viên có kết quả thực tập kém nhất lớp
CREATE PROCEDURE sp_sv_kem_nhat()
BEGIN
    DECLARE v_min FLOAT;
    SELECT MIN(kq) INTO v_min FROM Sd;
    SELECT Sv.*, Sd.dt, Sd.kq
    FROM Sv JOIN Sd ON Sv.sv = Sd.sv
    WHERE Sd.kq = v_min;
END //

-- 11. Thêm dữ liệu Sd, kiểm tra nếu dt >4 lần thì không cho thêm
CREATE PROCEDURE sp_them_sd_gioihan(
    IN p_sv VARCHAR(10),
    IN p_dt VARCHAR(10),
    IN p_ntt DATE,
    IN p_km FLOAT,
    IN p_kq FLOAT)
BEGIN
    DECLARE v_count INT;
    SELECT COUNT(*) INTO v_count FROM Sd WHERE dt = p_dt;
    IF v_count >= 4 THEN
        SELECT 'Đề tài này đã được chọn hơn 4 lần!' AS ThongBao;
    ELSE
        INSERT INTO Sd VALUES (p_sv, p_dt, p_ntt, p_km, p_kq);
    END IF;
END //

DELIMITER ;

-- =========================
-- KẾT THÚC TOÀN BỘ SCRIPT
-- =========================
