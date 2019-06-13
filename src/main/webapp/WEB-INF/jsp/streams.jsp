<html>
    <jsp:include page="head-tag.jsp"/>

    <body class="bg-light">

    <jsp:include page="nav.jsp"/>
        <div id="category"></div>
        <div id="category2"></div> 
        <div id="category3"></div> 
        <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.24.0/babel.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/react/15.4.2/react.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/react/15.4.2/react-dom.min.js"></script>
          
        <script type ="text/babel">
        class Category extends React.Component {	
            render() {
                return (
                    <div className="container-fluid">
                    <div className="container mt-2 pt-4 pb-3">
                      <nav aria-label="breadcrumb">
                        <ol className="breadcrumb" style={{background: "transparent"}}>
                          <li className="breadcrumb-item"><a href="#">Admin</a></li>
                          <li className="breadcrumb-item active" aria-current="page">Streams</li>
                        </ol>
                      </nav>
                    </div>
                  </div>
    );
    }
};

    class Category2 extends React.Component {
        render(){
            return (
                        <div className="container-fluid">
                        <div className="container">
                          <ul className="nav nav-tabs">
                            <li className="nav-item">
                              <a className="nav-link active" href="streams.htm">Streams</a>
                            </li>  
                            <li className="nav-item">
                              <a className="nav-link" href="category.htm">Category</a>
                            </li>
                            <li className="nav-item">
                              <a className="nav-link" href="modules.htm">Modules</a>
                            </li>
                            <li className="nav-item">
                              <a className="nav-link" href="courses.htm">Courses</a>
                            </li>
                            <li className="nav-item">
                              <a className="nav-link" href="admin.htm">Users</a>
                            </li>
                          </ul>
                        </div>
                      </div>
                    );
        }
    };
    $.ajaxSetup({
        async: false
    });

    function GetStreams() {
        var jsonData;
        $.getJSON("http://localhost:8084/WebAPI/getAllStreams", function(data) {
            jsonData = data;
        });

        var count = 1;
        
        const tablebody = jsonData.map((stream) =>
            <tr key={stream.streamId} value={stream.streamId}>
                    <th scope="row">{count++}</th>
                    <td><a href={"manage-stream.htm?id=" + stream.streamName}>{stream.streamName}</a></td>
            </tr>
        );

        return(
            <tbody>
                {tablebody}
            </tbody>
        );
    }
    class Category3 extends React.Component{	
        constructor(props){
            super(props);
            this.state = {streamN: ''};
            
            this.handleChange = this.handleChange.bind(this);
            this.handleSubmit = this.handleSubmit.bind(this);
        }
        
        handleChange(event){
            this.setState({streamN: event.target.value});
        }
        handleSubmit(event){
            var letters = '';
            this.state.streamN.toUpperCase().split(" ").forEach(function (word){
                letters += word.substring(0,1);
            });
            var streamId = letters + "123";
            var jsonVal = '{"streamId":"'+streamId+'", "streamName":"'+this.state.streamN+'"}';
            var json = JSON.parse(jsonVal);
            console.log(json);
            $.post("http://localhost:8084/WebAPI/createStream", json);
        }
        render() {
                return (
                <div className="container-fluid bg-white" style={{minHeight: "100vh"}}>
                    <div className="container pb-5">
                      <div className="row py-3">
                        <div className="col-lg-12">
                          <form onSubmit={this.handleSubmit}>
                          <div className="form">
                            <div className="form-row">
                              <div className="col-lg-2">
                                <button className="btn btn-sm btn-primary no-border mt-1" type="submit"><i class="fas fa-plus pr-2"></i>Insert Stream</button>
                              </div>
                              <div className="col-lg-10">
                               <input type="text" className="form-control" value={this.state.streamN} onChange={this.handleChange}
                                    id ="streamName" onchange="myFunction()" name="streamName" placeholder="Stream Name" 
                                    pattern="[a-zA-Z][a-zA-Z0-9-_.+#* ]{2,50}" title="Name must start with a letter and can only contain letters, numbers, hyphens, underscores, periods, hashtag, plus, star and be between 3 and 50 characters." required />
                              <div><small id="ajaxconf" className="text-danger"></small></div>
                              </div>
                            </div>
                          </div>
                        </form>
                        </div>
                      </div>

                      <table className="table table-striped table-bordered">
                        <thead>
                          <tr>
                            <th scope="col" style={{width: "10%"}}>#</th>
                            <th scope="col">Stream</th>
                          </tr>
                        </thead>

                         <GetStreams />

                      </table>
                    </div>
                  </div>

            );
        }
    };
    
    ReactDOM.render(<Category />, document.getElementById('category'));
    ReactDOM.render(<Category2 />, document.getElementById('category2'));
    ReactDOM.render(<Category3 />, document.getElementById("category3"));
                                                
</script> 
  <!-- /Tabs -->

  <!-- Optional JavaScript -->

  <!-- jQuery -->
  <script src="https://code.jquery.com/jquery-3.3.1.min.js" crossorigin="anonymous"></script>
  <!-- Popper.js -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
  <!-- Bootstrap.js -->
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

</body>
</html>

<script>
function myFunction()
{
  var sName = document.getElementById("streamName").value;
  
  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
     document.getElementById("ajaxconf").innerHTML = this.responseText;
    }
  };
  
  xhttp.open("GET", "ajaxconf.htm?name="+encodeURIComponent(sName)+"&num=7", true);
  xhttp.send();
}
</script>