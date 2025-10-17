-- Trigger tự động chuyển “0” và “1” thành “Nam” và “Nu”
DELIMITER //
CREATE TRIGGER trg_GioiTinh
BEFORE INSERT ON SinhVien
FOR EACH ROW
BEGIN
    IF NEW.GioiTinh = '0' THEN
        SET NEW.GioiTinh = 'Nam';
    ELSEIF NEW.GioiTinh = '1' THEN
        SET NEW.GioiTinh = 'Nu';
    END IF;
END;
//
DELIMITER ;

-- Trigger tự động ghép Họ và Tên thành HọTên
DELIMITER //
CREATE TRIGGER trg_HoTen
BEFORE INSERT ON SinhVien
FOR EACH ROW
BEGIN
    SET NEW.HoTen = CONCAT(NEW.Ho, ' ', NEW.Ten);
END;
//
DELIMITER ;
