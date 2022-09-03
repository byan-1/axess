import React from "react";
import ReactDOM from "react-dom";
import "../css/bootstrap.min.css";
import "../js/jquery-3.6.1.min.js";
import "../js/bootstrap.bundle.js";
ReactDOM.render(
  <div>
    <h1>Hello, react3!</h1>
    <button className="w-100 btn btn-lg btn-primary" type="submit">
      Sign in
    </button>
  </div>,
  document.getElementById("root")
);
