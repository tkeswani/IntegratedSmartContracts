<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.1/jquery.min.js"></script>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Smart Contract</title>
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

        <!-- jQuery library -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

        <!-- Latest compiled JavaScript -->
        <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    </head>
    <body>
        <form name="form1" action="ElasticSearch" enctype="multipart/form-data">
            <div class="container">
                <h1> Smart Contracts</h1>
                Select a file to upload:
                <input type="file" id="myFile" size="50">

                <p>Click the button below do the display the file path of the file upload button above (you must select a file first).</p>
                <button type="button" name="btnParseFile" id="btnParseFile">Parse My File</button>
                <input type="hidden" name="hiddenPath" value=""/>  
                <c:set var="hiddenPath" value="getHiddenPath()"/>
                <input type="hidden" name="hiddenFileName" value=""/>  
                <input type="hidden" name="page" value="1"/>
                <input type="hidden" name="action" value="getFile"/>
                <p id="demo" name="demo"></p>
                <input type="text" name="txtSearch" id="txtSearch"><br>

                <br>
                <input type="radio" name="ElasticSearchOption" value="DefinedTerms"> Defined Terms<br>
                <input type="radio" name="ElasticSearchOption" value="Article"> Article<br>
                <input type="radio" name="ElasticSearchOption" value="Section"> Section<br>
                <input type="radio" name="ElasticSearchOption" value="Semantic"> Semantic Search<br>
                <br>
                <button type="button" name="btnSearch" id="btnSearch">Search</button>
                <br>
                <button type="button" name="btnAnalyzeAgreement" id="btnAnalyzeAgreement">Analyze Agreement</button>
                <div id="ajaxGetUserServletResponse">
                </div>
                <textarea rows="4" cols="50" id="txtAnalyzeAgreement"></textarea>
        </form>

        <script>
            $(document).ready(function () {
                $("#btnParseFile").click(function () {
                    var x = document.getElementById("myFile").value;
                    var y = x.replace(/^.*[\\\/]/, '');
                    var val = y.split('.');
                    document.getElementById("demo").innerHTML = x;
                    var path = x.substring(0, x.lastIndexOf("\\") + 1);
                    document.form1.hiddenPath.value = path;
                    document.form1.hiddenFileName.value = y;
                    $.post("ElasticSearch",
                            {
                                path: path,
                                filename: y,
                                myParseFileClicked: true
                            },
                            function () {
                                alert("Complete Parsing");
                                $('#demo').text("File Successfully Parsed");
                                $('#demo').css("color", "green");
                            });
                });
                $("#btnSearch").click(function () {
                    var radioButtonClicked = $('input[name=ElasticSearchOption]:checked').val();
                    alert($('input[name=ElasticSearchOption]:checked').val());
                    alert("Hi" + $('#txtSearch').val());
                    $.post("ElasticSearch",
                            {
                                txtSearch: $('#txtSearch').val(),
                                myParseFileClicked: false,
                                radioButtonClicked: radioButtonClicked
                            },
                            function (responseText) {
                                alert("File Successfully Parsed");
                                $('#ajaxGetUserServletResponse').text(responseText);
                            });
                });
                $("#btnAnalyzeAgreement").click(function () {
                    var x = document.getElementById("myFile").value;
                    var y = x.replace(/^.*[\\\/]/, '');
                    var val = y.split('.');
                    document.getElementById("demo").innerHTML = x;
                    var path = x.substring(0, x.lastIndexOf("\\") + 1);
                    document.form1.hiddenPath.value = path;
                    document.form1.hiddenFileName.value = y;
                    $.post("ElasticSearch",
                            {
                                path: path,
                                filename: y,
                                myParseFileClicked: "analyzeAgreement",
                            },
                            function (responseText) {
                                alert("File Successfully Parsed");
                                $('#txtAnalyzeAgreement').val(responseText);
                            });
                });
            });
        </script>
    </body>
</html>
