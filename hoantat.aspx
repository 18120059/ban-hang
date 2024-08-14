<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="hoantat.aspx.cs" Inherits="hoantat" Title="Untitled Page" %>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Import Namespace="System.Configuration"%>
<%@ Import Namespace="System.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<% 
    string result = "";
    if (Session["giohang"] == null || Session["giohang"].ToString().Equals("0") || Session["hople"] == null)
        Response.Redirect("giohang.aspx");
    else if (Session["user"] == null)
        Response.Redirect("donhang.aspx");
    else if (Request.Form["phuongthucthanhtoan"] == null && Request.Form["phuongthucvanchuyen"] == null && Session["thanhtoan"] == null && Session["thanhtoan"]==null) 
        Response.Redirect("phuongthuc.aspx");
    else
    {
        if(Request.Form["phuongthucthanhtoan"]!=null)
            Session["thanhtoan"] = Request.Form["phuongthucthanhtoan"].ToString();
        if(Request.Form["phuongthucvanchuyen"]!=null)
            Session["vanchuyen"] = Request.Form["phuongthucvanchuyen"].ToString();
        string user = Session["user"].ToString();
        string sql = "select thanhvien.*,tenquocgia,tinh from tinh inner join (thanhvien inner join quocgia on thanhvien.quocgia=quocgia.maquocgia) on thanhvien.thanhpho=tinh.matinh where username like '" + user + "'";
        string connectString = ConfigurationManager.ConnectionStrings["dotnet"].ConnectionString;
        SqlConnection conn = new SqlConnection(connectString);
        conn.Open();
        SqlCommand comm = new SqlCommand(sql, conn);
        SqlDataReader reader = comm.ExecuteReader();
        reader.Read();
        result += "<table width='100%' bgcolor='#FFFFFF' cellspacing='0' cellpadding='0' border='0'>";
        result += "<tr><td>&nbsp;</td><td>&nbsp;</td><td></td><td></td><td></td><td>&nbsp;</td><td align='center'><img src='images/cart_move.gif'></td></tr>";
        result += "<tr style='font-size:13px;text-align:center'><td><a href='giohang.aspx' class='thoat'>Giỏ hàng</a></td><td valign='bottom'><img src='images/cart_arrow.gif'></td><td><a href='donhang.aspx' class='thoat'>Đơn hàng</ba</td><td valign='bottom'><img src='images/cart_arrow.gif'></td><td><a href='phuongthuc.aspx' class='thoat'>Vận chuyển-Thanh toán</a></td><td valign='bottom'><img src='images/cart_arrow.gif'></td><td><b>Hoàn tất</b></td></tr>";
        result += "<tr><td colspan='7'>";
        result += "<table width='100%' cellspacing='2' cellpadding='0' border='0'>";
        result += "<tr style='font-size:13px'><td><font color='red'>Thông tin khách hàng</font>&nbsp;<a href='thongtincanhan.aspx?type=2' class='thoat'>[Hiệu chỉnh]</td></tr>";
        result += "<tr><td align='center'>";
        result += "<table width='98%' border='1' class='Table_sp' cellspacing='0' cellpadding='0'>";
        result += "<tr><td><table width='100%' border='0' cellspacing='2' cellpadding='0'>";

        result += "<tr><td width='15'>&nbsp;</td><td style='font-size:13px' width='150' align='right'>Tên khách hàng</td><td width='15'>&nbsp;</td><td align='left'>" + reader["tenkh"].ToString() + "</td></tr>";

        result += "<tr><td width='15'>&nbsp;</td><td style='font-size:13px' width='150' align='right'>Địa chỉ</td><td width='15'>&nbsp;</td><td align='left'>" + reader["diachi"].ToString() + "</td></tr>";

        result += "<tr><td width='15'>&nbsp;</td><td style='font-size:13px' width='150' align='right'>Điện thoại</td><td width='15'>&nbsp;</td><td align='left'>" + reader["dienthoai"].ToString() + "</td></tr>";

        result += "<tr><td width='15'>&nbsp;</td><td style='font-size:13px' width='150' align='right'>Email</td><td width='15'>&nbsp;</td><td align='left'>" + reader["email"].ToString() + "</td></tr>";

        result += "<tr><td width='15'>&nbsp;</td><td style='font-size:13px' width='150' align='right'>Quốc gia</td><td width='15'>&nbsp;</td><td align='left'>" + reader["tenquocgia"].ToString() + "</td></tr>";

        result += "<tr><td width='15'>&nbsp;</td><td style='font-size:13px' width='150' align='right'>Tỉnh/TP</td><td width='15'>&nbsp;</td><td align='left'>" + reader["tinh"].ToString() + "</td></tr>";
        result += "</table></td></tr></table></td></tr></table>";
        comm.Dispose();
        reader.Dispose();
        result += "<tr style='font-size:13px'><td colspan='7'><font color='red'>Chi tiết đơn hàng</font></td></tr>";
        int len = Session["sanpham"].ToString().Split(';').Length - 1;//trong qua trinh noi luon noi them 1 san pham rong phia sau->loai bo san pham co ma rong
        string[] mangsp = Session["sanpham"].ToString().Split(';');
        string[] mangsl = Session["sl"].ToString().Split(';');
        string dk = "";
        string[] sluong = new string[1000];
        for (int i = 0; i < len; i++)
        {
            string tam = mangsp[i];
            tam = tam.Substring(2);
            int index = int.Parse(tam.ToString());
            sluong[index] = mangsl[i];
            //Response.Write(sluong[index].ToString());
            if (dk == "")
                dk = "('" + mangsp[i] + "'";
            else
                dk += ",'" + mangsp[i] + "'";
        }
        dk += ")";
        sql = "select * from sanpham where masp in " + dk + " order by masp";
        //Response.Write(sql);
        try
        {
            comm = new SqlCommand(sql, conn);
            reader = comm.ExecuteReader();
            result += "<tr><td colspan='7' align='center'>";
            result += "<table width='98%' cellspacing='0' cellpadding='0' border='1' class='Table_sp'>";
            result += "<tr bgcolor='#f9af3f' class='chucam'><th>Tên sản phẩm</th><th>Số lượng</th><th>Giá tiền</th><th>Hình</th></tr>";
            int tongtien = 0;
            string chitiet = "";
            while (reader.Read())
            {
                string tam = reader["masp"].ToString();
                tam = tam.Substring(2);
                int index = int.Parse(tam.ToString());
                int giaban = int.Parse(sluong[index].ToString()) * int.Parse(reader["gia"].ToString());
                tongtien += giaban;
                chitiet += reader["masp"].ToString() + "-" + sluong[index].ToString() + "-" + giaban.ToString() + ";";
                result += "<tr>";
                result += "<td>" + reader["tensp"].ToString() + "</td>";
                result += "<td align='center'>" + sluong[index].ToString() + "</td>";
                result += "<td align='right'>" + tien.tiente.chuyendoi(giaban.ToString()) + "</td>";
                result += "<td align='center'><img src='" + reader["hinh"].ToString() + "' width='60' height='60'></td>";
                result += "</tr>";
            }
            //tinh lai gia tri hoa don
            Session["tongtien"] = tongtien.ToString();
            Session["chitiet"] = chitiet;
            Session["tongsanpham"] = len.ToString();
            result += "</table></td></tr>";
            result += "<tr><td colspan='7' align='center'><table width='98%' bgcolor='999999' cellspacing='0' cellpadding='0' border='0'>";
            result += "<tr><td><table width='100%' cellspacing='0' cellpadding='0' border='0'>";
            result += "<tr><td width='60%' align='right'>Tổng tiền hàng</td><td align='right'><font color='0000ff'>" + tien.tiente.chuyendoi(Session["tongtien"].ToString()) + " VND</font></td></tr>";
            result += "<tr><td width='60%' align='right'>Phí vận chuyển</td><td align='right'><font color='0000ff'>0 VND</font</td></tr>";
            result += "<tr><td width='60%' align='right'>Tổng cộng</td><td align='right'><font color='0000ff'>" + tien.tiente.chuyendoi(Session["tongtien"].ToString()) + " VND</font></td></tr>";
            result += "</table></td></tr>";
            result += "<tr bgcolor='#FFFFFF'><td align='right'><form action='ketthuc.aspx' method='post'>";
            result += "<input type='submit' value='Thanh toán'>";
            result += "</form></td></tr></table></td></tr></table>";
            Response.Write(result);
            
        }
        catch (Exception e)
        {
            Response.Write(sql);
        }
        
        conn.Close();
    }
%>
</asp:Content>

