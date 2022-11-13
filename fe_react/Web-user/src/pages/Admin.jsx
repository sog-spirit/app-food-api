import React, { useRef, useState, useEffect } from "react";
import Helmet from "../components/Helmet/Helmet";
import CommonSection from "../components/UI/common-section/CommonSection";
import { Container, Row, Col } from "reactstrap";
import { Link } from "react-router-dom";

const AdninPage = () => {
  return (
    <Helmet title="AdminPage">
      <CommonSection title="AdminPage" />
      <h1>Hello World Admin</h1>
    </Helmet>
  );
};

export default AdninPage;
