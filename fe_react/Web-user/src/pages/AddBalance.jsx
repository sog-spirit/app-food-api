import React, { useState } from 'react'
import { Col, Container, Row } from 'reactstrap';
import Helmet from '../components/Helmet/Helmet';
import CommonSection from '../components/UI/common-section/CommonSection';

function AddBalance() {
    const [isError, setIsError] = useState(false)
    const [balanceForm, setBalanceForm] = useState({
        amount: 0,
        current_password: ""
    })
    const handleChange = (event) => {
        setBalanceForm({ ...balanceForm, [event.target.name]: event.target.value });
      };
    const submitHandler = async (e) => {
        e.preventDefault()
        console.log(balanceForm);
    }
  return (
    <Helmet title="Nạp tiền">
        <CommonSection title="Nạp tiền" />
        <section>
          <Container>
            <Row>
              <Col lg="6" md="6" sm="12" className="m-auto text-center">
                <form className="form mb-5" onSubmit={(e) => submitHandler(e)}>
                  <div className="form__group">
                    <input
                      type="number"
                      placeholder="Số tiền"
                      name="amount"
                      required
                      onChange={(e) => {
                        handleChange(e)
                      }}
                    />
                  </div>
                  <div className="form__group">
                    <input
                      type="password"
                      placeholder="Mật khẩu"
                      name="current_password"
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
                    Nạp tiền
                  </button>
                </form>
              </Col>
            </Row>
          </Container>
        </section>
      </Helmet>
  )
}

export default AddBalance