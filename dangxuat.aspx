<%@ Page Language="C#" %>

<% 
    if (Session["user"] != null)
    {
        Session["user"] = null;
        Session["loaitk"] = null;
        Session["giohang"] = null;
        Session["sanpham"] = null;
        Session["sl"] = null;
        Session["error"]=null;
        Session["hople"] = null;
        Session["thanhtoan"] = null;
        Session["vanchuyen"] = null;
        if((int)Application["sothanhvien"]>0)
            Application["sothanhvien"] = (int)Application["sothanhvien"] - 1;
        Session["dadangnhap"] = false;
        Response.Redirect("Default.aspx");
    }
%>
