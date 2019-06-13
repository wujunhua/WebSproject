    <%
        // get session attribute, used to hide admin link
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");

    %>
<div id="nav"></div>   
<script src="https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.24.0/babel.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/react/15.4.2/react.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/react/15.4.2/react-dom.min.js"></script>

<script type ="text/babel">
    class Nav extends React.Component
    {	render() {
    return (
    <nav className = "navbar navbar-expand-lg navbar-dark" style = {{background:" rgb(0,102,161)"}} >
        <div className ="container">
           <a className="navbar-brand" href="#">

          <img style={{height:"50px"}} position="inline-block" src="resources/img/logo_1.png"/>
          </a>
          <button className="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
          <span className="navbar-toggler-icon"></span>
          </button>
                    <div className="collapse navbar-collapse" id="navbarNav">
                        <ul className="navbar-nav mr-auto">
                            <li className="nav-item">

                            <% if (isAdmin) { // only show admin button if they are an admin %> 
                            <a className="nav-link" href="streams.htm">Admin <span className="sr-only">(current)</span></a>
                            <% } %>  

                            </li>
                            <li className="nav-item">
                            <a className="nav-link" href="createclass.htm">Instructor</a>
                            </li>
                        </ul>
                    <ul className="navbar-nav d-md-none d-lg-block">
                            <div className="btn-group mr-3">
                            <button style={{color: "#fff"}} className="btn btn-sm dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">

                                <small> <i className="fas fa-user pr-1"></i>${sessionScope.currentUserName}</small>
                            </button>
                                        <div className="dropdown-menu">
                                            <a className="dropdown-item" href="changePassword.htm"><small><i className="fas fa-lock pr-2"></i>Change Password</small></a>
                                                <div className="dropdown-divider"></div>
                                            <a className="dropdown-item" href="login.htm"><small>Logout</small></a>
                                        </div>
                            </div>
                    </ul>
          </div>
          </div>
    </nav>
    );}};
    
    ReactDOM.render(<Nav />, document.getElementById('nav'));
   
</script>
