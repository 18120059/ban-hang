<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" Title="Untitled Page" %>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Import Namespace="System.Configuration"%>
<%@ Import Namespace="System.Data" %>
<asp:Content ID="Content" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <% 
    Response.ContentType = "text/html;charset=utf-8";
    string masp = Request.QueryString["masp"];
    if (masp == null)
        masp = "";
    if (masp != "")
    {
        string connectString = ConfigurationManager.ConnectionStrings["dotnet"].ConnectionString;
        SqlConnection conn = new SqlConnection(connectString);
        conn.Open();
        string sql = "select sanpham.*,tenchungloai from sanpham inner join (loai inner join chungloai on loai.machungloai=chungloai.machungloai) on sanpham.maloai=loai.maloai where sanpham.masp like '" + masp + "'";
        //tao doi tuong thuc thi sql
        SqlCommand comm = new SqlCommand(sql, conn);
        SqlDataReader reader = comm.ExecuteReader();
        string result = "<table width='100%' bgcolor='#FFFFFF' border='0'cellspacing='2' cellpadding='0'>";
        reader.Read();
        result += "<tr><td rowspan='3' valign='middle' align='center' width='200'><img src='" + reader["hinh"].ToString() + "' width='200' height='150'></td>";
        result += "<td valign='top'><table width='100%' border='1' class='Table_sp' cellspacing='0' cellpadding='0'>";
        result += "<tr bgcolor='#996633'><th>Chi tiết sản phẩm</td></tr>";
        result += "<tr><td><table width='100%' border='0' cellspacing='0' cellpadding='0'>";
        result += "<tr><td class='sanpham' width='40%' nowrap>Chủng loại</td><td>" + reader["tenchungloai"].ToString() + "</td></tr>";
        result += "<tr><td colspan='2'>&nbsp;</td></tr>";
        result += "<tr><td class='sanpham'>Tên sản phẩm</td><td>" + reader["tensp"].ToString() + "</td></tr>";
        result += "<tr><td colspan='2'>&nbsp;</td></tr>";
        result += "<tr><td class='sanpham'>Mô tả</td><td>" + reader["mota"].ToString() + "</td></tr>";
        result += "<tr><td colspan='2'>&nbsp;</td></tr>";
        if (reader["kichco"].ToString() != "")
        {
            result += "<tr><td class='sanpham'>Kích cỡ</td><td>" + reader["kichco"].ToString() + "</td></tr>";
            result += "<tr><td colspan='2'>&nbsp;</td></tr>";
        }
        if (reader["bangtan"].ToString() != "")
        {
            result += "<tr><td class='sanpham'>Băng tần</td><td>" + reader["bangtan"].ToString() + "</td></tr>";
            result += "<tr><td colspan='2'>&nbsp;</td></tr>";
        }
        if (reader["camera"].ToString() != "")
        {
            result += "<tr><td class='sanpham'>Camera</td><td>" + reader["camera"].ToString() + "</td></tr>";
            result += "<tr><td colspan='2'>&nbsp;</td></tr>";
        }
        if (reader["GPRS"].ToString() != "")
        {
            result += "<tr><td class='sanpham'>GPRS</td><td>" + reader["GPRS"].ToString() + "</td></tr>";
            result += "<tr><td colspan='2'>&nbsp;</td></tr>";
        }
        if (reader["xuatxu"].ToString() != "")
        {
            result += "<tr><td class='sanpham'>Xuất xứ</td><td>" + reader["xuatxu"].ToString() + "</td></tr>";
            result += "<tr><td colspan='2'>&nbsp;</td></tr>";
        }
        if (reader["dactinh"].ToString() != "")
        {
            result += "<tr><td class='sanpham'>Đặc tính</td><td>" + reader["dactinh"].ToString() + "</td></tr>";
            result += "<tr><td colspan='2'>&nbsp;</td></tr>";
        }
        result += "</table></td></tr></table><br></td></tr>";
        result += "<tr><td valign='top'>Giá:<span class='giathanh'>" + tien.tiente.chuyendoi(reader["gia"].ToString()) + " VND</span><p></td></tr>";
        result += "<tr><td align='center'><input type='text' size='1' class='cell' name='txt" + reader["masp"].ToString() + "' value='1' style='text-align:center'>&nbsp;<input type='button' name='cmd" + reader["masp"].ToString() + "' onclick='return addtocart(this)' value='Mua'>&nbsp;<a href='giohang.aspx' class='thoat'>Tính tiền</a>&nbsp;";
        if(Session["url"]==null)
            Session["url"]="Default.aspx";
        result+="<a href='" + Session["url"].ToString() + "' class='thoat'>Trở về</a></td></tr>";
        result += "</table>";
        Response.Write(result);
    }
%>
 <form id="Form1" runat =server>   
     
  
 </FORM>    
</asp:Content>

