<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Import Namespace="System.Configuration"%>
<%@ Import Namespace="System.Data" %>
<% 
    Response.ContentType = "text/html;charset=utf-8";
    string user = Request.QueryString["user"];
    string email=Request.QueryString["email"];
    string connectString = ConfigurationManager.ConnectionStrings["dotnet"].ConnectionString;
    SqlConnection conn = new SqlConnection(connectString);
    conn.Open();
    if(user!="")
    {
        SqlCommand sqluser = new SqlCommand("select username from thanhvien where username='" + user + "'", conn);
        SqlDataReader reader = sqluser.ExecuteReader();
        if (reader.Read())
            Response.Write("*");
        reader.Dispose();
    }
    if (email != "")
    {
        SqlCommand sqluser = new SqlCommand("select email from thanhvien where email='" + email + "'", conn);
        SqlDataReader reader = sqluser.ExecuteReader();
        if (reader.Read())
            Response.Write("*");
        reader.Dispose();
    }
    conn.Close();
%>
