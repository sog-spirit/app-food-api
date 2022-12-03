import React from "react";
import Helmet from "../../components/Helmet/Helmet";
import SlideBar from "../../components/UI/slider/SlideBar";
import "../../styles/dashboard.scss";
import "../../styles/admin.scss";

const Admin = () => {
  //date time picker
  const [value, setValue] = React.useState(null);

  return (
    <Helmet title="AdminPage">
      <div className="admin__section d-flex">
        <SlideBar />
        <div className="main__content">
          <h1>This is dashboard</h1>
        </div>
      </div>
    </Helmet>
  );
};

export default Admin;
