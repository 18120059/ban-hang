<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="phuongthuc.aspx.cs" Inherits="phuongthuc" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<script language="javascript">
	function test(object)
	{
		if(object.name=="phuongthucthanhtoan")
			if(document.getElementById(object.name).value!=2)
				document.getElementById("txtMa").style.display='none';
			else
				document.getElementById("txtMa").style.display='';
	}
	function check(form)
	{
		var vanchuyen=document.getElementById("phuongthucvanchuyen").value;
		var thanhtoan=document.getElementById("phuongthucthanhtoan").value;
		var flag=true;
		if (vanchuyen=="" || thanhtoan=="")
		{
			alert ("Ban phai chon phuong thuc thanh toan va van chuyen");
			return false;
		}
		return flag;
	}
</script>
<% 
    
    string result = "";
    if (Session["giohang"] == null || Session["giohang"].ToString().Equals("0") || Session["hople"] == null)
        Response.Redirect("giohang.aspx");
    else if (Session["user"] == null)
        Response.Redirect("donhang.aspx");
    else
    {
        result += "<table width='100%' bgcolor='#FFFFFF' cellspacing='0' cellpadding='0' border='0'>";
        result += "<tr><td>&nbsp;</td><td>&nbsp;</td><td></td><td></td><td align='center'><img src='images/cart_move.gif'></td><td>&nbsp;</td><td></td></tr>";
        result += "<tr style='font-size:13px;text-align:center'><td><a href='giohang.aspx' class='thoat'>Giỏ hàng</a></td><td valign='bottom'><img src='images/cart_arrow.gif'></td><td><a href='donhang.aspx' class='thoat'>Đơn hàng</ba</td><td valign='bottom'><img src='images/cart_arrow.gif'></td><td><b>Vận chuyển-Thanh toán</b></td><td valign='bottom'><img src='images/cart_arrow.gif'></td><td>Hoàn tất</td></tr>";
        result += "<tr><td colspan='7'>&nbsp;</td></tr>";
        result += "<tr><td colspan='7'><form name='pt' action='hoantat.aspx' method='post' onsubmit='return check(this)'><table width='100%' cellspacing='2' cellpadding='0' border='0'>";
        result += "<tr><td align='center'><select name='phuongthucthanhtoan' class='cell' onchange='test(this)'><option value=''>--Phương thức thanh toán--</option>";
        result += "<option value='1'>Tiền mặt</option><option value='2'>Tài khoản ngân hàng</option></select></td>";
        result += "<td align='center'><select name='phuongthucvanchuyen' class='cell' onchange='test(this)'><option value=''>--Phương thức vận chuyển--</option>";
        result += "<option value='1'>Trong nước</option><option value='2'>Ngoài nước</option></select></td></tr>";
        result += "<tr><td></td></tr>";
        result += "<tr><td><span class='sanpham'>Mã thẻ</span>&nbsp;<input type='text' name='txtMa' size='16' value='1792 0101 1949 7997'disabled style='display:none;color:blue'></td><td></td></tr>";
        result += "<tr><td colspan='2' align='right'><input type='submit' value='Tiếp tục'></td></tr>";
        result += "</table></form></td></tr></table>";
        Response.Write(result);
    }
%>
</asp:Content>

