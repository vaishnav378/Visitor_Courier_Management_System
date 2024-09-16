using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.UI;

namespace vms1
{
    public class MvcApplication : System.Web.HttpApplication
    {
        public class HttpSignalR { }
        protected void Application_Start(object sender, EventArgs e)
        {
            AreaRegistration.RegisterAllAreas();
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);


            ScriptManager.ScriptResourceMapping.AddDefinition("jquery", new ScriptResourceDefinition
            {
                Path = "~/Scripts/jquery-3.7.1.min.js",
                DebugPath = "~/Scripts/jquery-3.7.1.js",
                CdnPath = "https://code.jquery.com/jquery-3.7.1.min.js",
                CdnDebugPath = "https://code.jquery.com/jquery-3.7.1.js"
            });
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {
            // Redirect root URL to Login.aspx
            if (Request.Path == "/" || Request.Path == "/default.aspx")
            {
                Response.Redirect("~/Login.aspx");
            }
        }
    }
}
