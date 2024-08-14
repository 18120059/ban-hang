<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="suathongtin.aspx.cs" Inherits="suathongtin" Title="Untitled Page" %>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Import Namespace="System.Configuration"%>
<%@ Import Namespace="System.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<% 
    if (Request.Form["cmdSuathongtin"] != null && Session["user"]!=null)
    {
        string tenkh=Request.Form["tenkhachhang"].ToString();
        string diachi = Request.Form["diachi"].ToString();
        string dienthoai = Request.Form["dienthoai"].ToString();
        string email = Request.Form["email"].ToString();
        string namsinh = Request.Form["namsinh"].ToString();
        string quocgia = Request.Form["quocgia"].ToString();
        string tinh = Request.Form["tinh"].ToString();
        string url=Request.Form["url"].ToString();
        string connectString = ConfigurationManager.ConnectionStrings["dotnet"].ConnectionString;
        SqlConnection conn = new SqlConnection(connectString);
        conn.Open();
        string user=Session["user"].ToString();
        string sql = "update thanhvien set tenkh=N'" + tenkh + "',diachi=N'" + diachi + "',dienthoai='" + dienthoai + "',namsinh='" + namsinh + "',email='" + email + "',quocgia=N'" + quocgia + "',thanhpho=N'" + tinh + "' where username like '" + user + "'";
        try
        {
            SqlCommand comm = new SqlCommand(sql, conn);
            comm.ExecuteNonQuery();
            Response.Redirect(url);
        }
        catch (Exception e)
        {
            Response.Write(sql);
        }
    }
%>
</asp:Content>

