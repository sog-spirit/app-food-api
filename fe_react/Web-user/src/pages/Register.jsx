import React from "react";
import Helmet from "../components/Helmet/Helmet";
import CommonSection from "../components/UI/common-section/CommonSection";
import { Container, Row, Col } from "reactstrap";
import { Link } from "react-router-dom";
import "../styles/register.scss";

//date time picker
import TextField from "@mui/material/TextField";
import { AdapterDayjs } from "@mui/x-date-pickers/AdapterDayjs";
import { LocalizationProvider } from "@mui/x-date-pickers/LocalizationProvider";
import { DatePicker } from "@mui/x-date-pickers/DatePicker";

const Register = () => {
  const submitHandler = (e) => {
    e.preventDefault();
  };

  const [value, setValue] = React.useState(null);

  return (
    <Helmet title="Signup">
      <CommonSection title="Tạo tài khoản" />
      <section>
        <Container>
          <Row>
            <Col lg="6" md="6" sm="12" className="m-auto text-center">
              <form className="form" onSubmit={submitHandler}>
                <div className="form-group text-left">
                  <label>Họ và tên</label>
                  <input type="text" className="form-control" required />
                </div>
                <div className="form-group text-left">
                  <label>Tên đăng nhập</label>
                  <input type="text" className="form-control" required />
                </div>
                <div className="form-group text-left">
                  <label>Email</label>
                  <input type="email" className="form-control" required />
                </div>
                <div className="form-group text-left">
                  <label>Số điện thoại</label>
                  <input type="text" className="form-control" required />
                </div>
                <div className="form-group text-left">
                  <label>Địa chỉ</label>
                  <input type="text" className="form-control" required />
                </div>
                <div className="form-group text-left">
                  <label>Ngày sinh</label>
                  <LocalizationProvider
                    dateAdapter={AdapterDayjs}
                    style={{ width: "fit-content" }}
                  >
                    <DatePicker
                      label="Basic example"
                      value={value}
                      onChange={(newValue) => {
                        setValue(newValue);
                      }}
                      renderInput={(params) => <TextField {...params} />}
                    />
                  </LocalizationProvider>
                </div>
                <div className="form-group text-left">
                  <label>Hình ảnh</label>
                  <input
                    type="file"
                    accept="image/jpeg, image/png, image/jpg"
                    multiple
                  />
                  <div id="display-image"></div>
                </div>
                <div className="form-group text-left">
                  <label>Mật khẩu</label>
                  <input type="password" className="form-control" required />
                </div>
                <div className="form-group text-left">
                  <label>Nhập lại mật khẩu</label>
                  <input type="password" className="form-control" required />
                </div>

                <button type="submit" className="addTOCart__btn">
                  Đăng kí
                </button>
              </form>
              <Link to="/login">Bạn đã có tài khoản ? Đăng nhập</Link>
            </Col>
          </Row>
        </Container>
      </section>
    </Helmet>
  );
};

export default Register;
