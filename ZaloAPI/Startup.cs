using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(ZaloAPI.Startup))]
namespace ZaloAPI
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
