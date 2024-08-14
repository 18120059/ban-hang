<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="donhang.aspx.cs" Inherits="donhang" Title="Untitled Page" %>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Import Namespace="System.Configuration"%>
<%@ Import Namespace="System.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<% 
    
    string result = "";
    if (Session["giohang"] == null || Session["giohang"].ToString().Equals("0") || Session["hople"]==null)
        Response.Redirect("giohang.aspx");
    else
    {
        result += "<table width='100%' bgcolor='#FFFFFF' cellspacing='0' cellpadding='0' border='0'>";
        result += "<tr><td>&nbsp;</td><td>&nbsp;</td><td align='center'><img src='images/cart_move.gif'></td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>";
        result += "<tr style='font-size:13px;text-align:center'><td><a href='giohang.aspx' class='thoat'>Giỏ hàng</a></td><td valign='bottom'><img src='images/cart_arrow.gif'></td><td><b>Đơn hàng</b></td><td valign='bottom'><img src='images/cart_arrow.gif'></td><td>Vận chuyển-Thanh toán</td><td valign='bottom'><img src='images/cart_arrow.gif'></td><td>Hoàn tất</td></tr>";
        result += "<tr><td colspan='7'>&nbsp;</td></tr>";
        //Response.Write(result);
        if (Session["user"] == null)
        {

            result += "<tr><td align='center' colspan='7'>Bạn chưa đăng nhập.Xin đăng nhập</td></tr>";
            result += "<tr><td align='center' colspan='7'>&nbsp;</td></tr>";
            result += "<tr><td colspan='7'><table align='center' width='350' border='0' bgcolor='#FFFFFF' class='Table' cellspacing='0' cellpadding='0' style='border-color:#CC3300'><form action='checklogin.aspx' method='post' name='dangnhap1' onsubmit='return check_dn(this)'>";
            result += "<tr><td colspan='2' height='30' background ='images/ban_dn.gif' align =center class='tuabanner'>Đăng nhập</td></tr>";
            result += "<tr><td>&nbsp;</td></tr>";
            result += "<tr><td>&nbsp;</td></tr>";
            result += "<tr><td>&nbsp;Username</td>";
            result += "<td>&nbsp;<input type='text' size='20' maxlength=30 class='cell' name='txtuser'></td></tr>";
            result += "<tr><td>&nbsp;Password</td>";
            result += "<td>&nbsp;<input type='password' maxlength=30 class='cell' size='20' name='txtpass'></td></tr>";
            result += "<tr><td>&nbsp;</td></tr>";
            result += "<tr><td align='center' colspan='2'><input type='submit' name='cmdDangnhap' value='Đăng nhập'></td></tr>";
            if (Session["error"] != null)
                result += "<tr><td align='center' colspan='2' style='color:red'>Sai user hoặc pass</td></tr>";
            Session["error"] = null;
            result += "<input type='hidden' name='url_donhang' value='donhang.aspx'>";
            result += "</form></table></td></tr>";
            result += "<tr><td colspan='7'>&nbsp;</td></tr>";
            result += "<tr><td colspan='7' align='center'>Nếu bạn chưa có tài khoản hãy nhấn vào <a href='dangky.aspx?type=1' class='thoat'>đây</a> để đăng ký</td></tr>";
            result += "<tr><td colspan='7'>&nbsp;</td></tr></table>";
            Response.Write(result);
            //Response.Write(Session["url"].ToString());
        }
        else
        {
            string user = Session["user"].ToString();
            string sql = "select thanhvien.*,tenquocgia,tinh from tinh inner join (thanhvien inner join quocgia on thanhvien.quocgia=quocgia.maquocgia) on thanhvien.thanhpho=tinh.matinh where username like '" + user + "'";
            string connectString = ConfigurationManager.ConnectionStrings["dotnet"].ConnectionString;
            SqlConnection conn = new SqlConnection(connectString);
            conn.Open();
            try
            {
                SqlCommand comm = new SqlCommand(sql, conn);
                SqlDataReader reader = comm.ExecuteReader();
                reader.Read();
                result += "<tr style='font-size:13px'><td colspan='7'><font color='red'>Thông tin khách hàng</font>&nbsp;<a href='thongtincanhan.aspx?type=1' class='thoat'>[Hiệu chỉnh]</td></tr>";
                result += "<tr><td colspan='7'>&nbsp;</td></tr>";
                result += "<tr><td colspan='7' align='center'>";
                result += "<table width='98%' border='1' class='Table_sp' cellspacing='0' cellpadding='0'>";
                result += "<tr><td><table width='100%' border='0' cellspacing='2' cellpadding='0'>";

                result += "<tr><td width='15'>&nbsp;</td><td style='font-size:13px' width='150' align='right'>Tên khách hàng</td><td width='15'>&nbsp;</td><td align='left'>" + reader["tenkh"].ToString() + "</td></tr>";

                result += "<tr><td width='15'>&nbsp;</td><td style='font-size:13px' width='150' align='right'>Địa chỉ</td><td width='15'>&nbsp;</td><td align='left'>" + reader["diachi"].ToString() + "</td></tr>";

                result += "<tr><td width='15'>&nbsp;</td><td style='font-size:13px' width='150' align='right'>Điện thoại</td><td width='15'>&nbsp;</td><td align='left'>" + reader["dienthoai"].ToString() + "</td></tr>";

                result += "<tr><td width='15'>&nbsp;</td><td style='font-size:13px' width='150' align='right'>Email</td><td width='15'>&nbsp;</td><td align='left'>" + reader["email"].ToString() + "</td></tr>";

                result += "<tr><td width='15'>&nbsp;</td><td style='font-size:13px' width='150' align='right'>Quốc gia</td><td width='15'>&nbsp;</td><td align='left'>" + reader["tenquocgia"].ToString() + "</td></tr>";

                result += "<tr><td width='15'>&nbsp;</td><td style='font-size:13px' width='150' align='right'>Tỉnh/TP</td><td width='15'>&nbsp;</td><td align='left'>" + reader["tinh"].ToString() + "</td></tr>";
                result += "</table></td></tr></table></td></tr>";
                result += "<tr><td colspan='7' align='right'><form action='phuongthuc.aspx' method='post'>";
                result += "<input type='submit' value='Tiếp tục'>";
                result += "</form></td></tr>";
                result += "</table>";
                Response.Write(result);
            }
            catch (Exception e)
            {
                Response.Write(sql);
            }
            conn.Close();
        }
    }
%>
</asp:Content>

