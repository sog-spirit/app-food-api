import React from "react";
import Routes from "../../routes/Routers";
import Slidebar from "../UI/slider/SlideBar";

const DashBoard = () => {
  return (
    <div class="admin__section d-flex">
      <Slidebar />
      <Routes />
    </div>
  );
};

export default DashBoard;
