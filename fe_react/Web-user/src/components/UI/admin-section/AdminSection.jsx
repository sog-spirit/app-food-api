import React from "react";
import { Container } from "reactstrap";
import Slidebar from "../slider/SlideBar";
import "../../../styles/admin-page.scss";
const AdminSection = (props) => {
  return (
    <div class="admin__slidebar d-flex">
      <Slidebar />
    </div>
  );
};

export default AdminSection;
