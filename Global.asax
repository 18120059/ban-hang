<%@ Application Language="C#" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e) 
    {
        Application["sltruynhap"] = 0;
        Application["sothanhvien"] = 0;
    }
    
    void Application_End(object sender, EventArgs e) 
    {
        

    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
        // Code that runs when an unhandled error occurs

    }

    void Session_Start(object sender, EventArgs e) 
    {
        Application["sltruynhap"] = (int)Application["sltruynhap"] + 1;
        Session["dadangnhap"] = false;
    }

    void Session_End(object sender, EventArgs e) 
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.
        if ((int)Application["sothanhvien"] > 0 && (bool)Session["dadangnhap"]==true)
            Application["sothanhvien"] = (int)Application["sothanhvien"] - 1;
    }
       
</script>
