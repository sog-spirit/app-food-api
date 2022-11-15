import React, { useState } from "react";
import Helmet from "../components/Helmet/Helmet";
import CommonSection from "../components/UI/common-section/CommonSection";
import { Container, Row, Col } from "reactstrap";
import Cookies from "js-cookie";
import { useNavigate } from "react-router-dom";

function ChangePassword() {
    const navigate = useNavigate();
    const [isError, setIsError] = useState(false)
    const [passwordInfo, setPasswordInfo] = useState({
        oldPassword: "",
        newPassword: "",
        confirmPassword: "",
    })
    const handleChange = (event) => {
        setPasswordInfo({ ...passwordInfo, [event.target.name]: event.target.value });
      };
    const submitHandler = async (e) => {
      e.preventDefault();
      if (passwordInfo.newPassword !== passwordInfo.confirmPassword) {
        setIsError(true)
        setTimeout(() => {
            setIsError(false)
        }, 2000);
      }
      else {
        await fetch(`http://localhost:8000/api/user/update/password`, {
          method: 'PATCH',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': `jwt=${Cookies.get('jwt')}`
          },
          body: JSON.stringify({
            current_password: passwordInfo.oldPassword,
            new_password: passwordInfo.newPassword}),
          credentials: 'include'
        }).then((response) => {
          if (response.status !== 200) {
            setIsError(true)
            setTimeout(() => {
                setIsError(false)
            }, 2000);
          }
          else {
            navigate('/home')
          }
        })
      }
    };

    return (
      <Helmet title="Update Password">
        <CommonSection title="Update Password" />
        <section>
          <Container>
            <Row>
              <Col lg="6" md="6" sm="12" className="m-auto text-center">
                <form className="form mb-5" onSubmit={(e) => submitHandler(e)}>
                  <div className="form__group">
                    <input
                      type="password"
                      placeholder="Mật khẩu cũ"
                      name="oldPassword"
                      required
                      onChange={(e) => {
                        handleChange(e)
                      }}
                    />
                  </div>
                  <div className="form__group">
                    <input
                      type="password"
                      placeholder="Mật khẩu mới"
                      name="newPassword"
                      required
                      onChange={(e) => {
                          handleChange(e)
                      }}
                      />
                  </div>
                  <div className="form__group">
                    <input
                      type="password"
                      placeholder="Nhập lại mật khẩu"
                      name="confirmPassword"
                      required
                      onChange={(e) => {
                        handleChange(e)
                      }}
                    />
                  {isError && <span style={{color: "red"}}>Error</span>}
                  </div>
                  <button
                    onClick={(e) => submitHandler(e)}
                    type="submit"
                    className="addTOCart__btn"
                    >
                    Save
                  </button>
                </form>
              </Col>
            </Row>
          </Container>
        </section>
      </Helmet>
    )
}

export default ChangePassword