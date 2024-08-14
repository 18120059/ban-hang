<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ketthuc.aspx.cs" Inherits="ketthuc" Title="Untitled Page" %>
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
    else if (Session["thanhtoan"] == null || Session["vanchuyen"] == null)
        Response.Redirect("phuongthuc.aspx");
    else
    {
        string sql = "";
        try
        {
            string user = Session["user"].ToString();
            string tongsanpham = Session["tongsanpham"].ToString();
            string tongtien = Session["tongtien"].ToString();
            sql = "select id from thanhvien where username like '" + user + "'";
            string connectString = ConfigurationManager.ConnectionStrings["dotnet"].ConnectionString;
            SqlConnection conn = new SqlConnection(connectString);
            conn.Open();
            SqlCommand comm = new SqlCommand(sql, conn);
            SqlDataReader reader = comm.ExecuteReader();
            reader.Read();
            int idkh = int.Parse(reader["id"].ToString());
            reader.Dispose();
            comm.Dispose();
            sql = "select TOP 1 mahd from hoadon order by mahd desc";
            comm = new SqlCommand(sql, conn);
            reader = comm.ExecuteReader();
            string mahoadon = "";
            if (reader.Read())
            {
                int idhd = int.Parse(reader["mahd"].ToString().Substring(2));
                idhd++;
                mahoadon = "hd" + idhd.ToString();
            }
            else
                mahoadon = "hd1";
            reader.Dispose();
            comm.Dispose();
            sql = "insert into hoadon(mahd,id,thanhtoan,vanchuyen,tongmathang,tongtien) values('" + mahoadon + "'," + idkh + ",'" + Session["thanhtoan"].ToString() + "','" + Session["vanchuyen"].ToString() + "'," + tongsanpham + "," + tongtien + ")";
            comm = new SqlCommand(sql, conn);
            comm.ExecuteNonQuery();
            reader.Dispose();
            comm.Dispose();
            string[] mangsp = Session["chitiet"].ToString().Split(';');
            int len1 = Session["chitiet"].ToString().Split(';').Length - 1;
            for (int i = 0; i < len1; i++)
            {
                string[] tam = mangsp[i].Split('-');
                string masp = tam[0];
                string soluong = tam[1];
                string giaban = tam[2];
                sql = "insert into chitiethoadon values('" + mahoadon + "','" + masp + "'," + soluong + "," + giaban + ")";
                comm = new SqlCommand(sql, conn);
                comm.ExecuteNonQuery();
                comm.Dispose();
            }
            Session["giohang"] = "0";
            Session["sanpham"] = "";
            Session["sl"] = "";
            Session["hople"] = null;
            Session["thanhtoan"] = null;
            Session["vanchuyen"] = null;
            result = "<table width='100%' border='1' class='Table_sp' align='center' bgcolor='#FFFFFF' cellspacing='0' cellpadding='0'><tr><td><span style='font-size:13px;text-align:center'><br>Đơn đặt hàng của bạn đã được chúng tôi ghi nhận.<br>Xin cảm ơn bạn đã đặt hàng.Nếu bạn muốn tiếp tục mua hàng thì hãy click vào <a href='Default.aspx' class='thoat'>đây</a> để tiếp tục mua hàng</span><br><br></td></tr></table>";
            Response.Write(result);
        }
        catch (Exception e)
        {
            Response.Write(sql);
        }
            
    }
    
%>
</asp:Content>

