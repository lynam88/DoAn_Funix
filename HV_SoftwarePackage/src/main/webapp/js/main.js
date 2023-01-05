/* =========================================== */
/* =========================================== */
function validate() {
	var startDate = document.getElementById("startDate").value;
	var endDate = document.getElementById("endDate").value;
    if (startDate.compareTo(endDate) > 0) {
				alert("Ngày Bắt Đầu phải trước Ngày Kết Thúc");
				return;
			}else {
			alert("Ngày Bắt Đầu phải trước Ngày Kết Thúc11111111111111111111");
				return;
			}
    }