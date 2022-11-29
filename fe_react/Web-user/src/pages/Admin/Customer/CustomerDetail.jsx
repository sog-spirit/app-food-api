import React, { useRef, useState, useEffect } from "react";
import Helmet from "../../../components/Helmet/Helmet";
import "../../../styles/dashboard.scss";
import "../../../styles/admin.scss";

import {
    Form,
    Button,
    FormGroup,
    FormControl,
    ControlLabel,
  } from "react-bootstrap";
import { useNavigate, useParams } from "react-router-dom";
import Cookies from "js-cookie";
import ModalBox from "../../../components/UI/ModalBox";
import Slidebar from "../../../components/UI/slider/SlideBar";

function CustomerDetail() {
  const navigate = useNavigate();
  const {id} = useParams()
  const [user, setUser] = useState({})
  const [isModal, setIsModal] = useState(false);
  const handleChange = async (event) => {
    setUser({ ...user, [event.target.name]: event.target.value });
  };

  useEffect(() => {
    getUserDetail()
  }, [])

  const getUserDetail = async () => {
    await fetch(`http://localhost:8000/api/admin/users/${id}`, {
      headers: {
        'Authorization': `jwt=${Cookies.get('jwt')}`
      },
      method: 'GET',
      credentials: 'include'
    })
      .then((res) => res.json())
      .then((data) => {
        setUser(data)
      })
  }

  const handleSubmit = async (e) => {
    e.preventDefault()
    await fetch(`http://localhost:8000/api/admin/users/${id}`, {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
          Authorization: `jwt=${Cookies.get("jwt")}`,
        },
        body: JSON.stringify(user),
        credentials: "include",
    }).then((response) => {
        if (response.status === 200) {
            navigate("/admin/users");
        }
        else {
            setIsModal(true)
        }
    })
  }

  const closeModal = (e) => {
    setIsModal(false);
  };

  return (
    <Helmet title="AdminPage">
        <div className="admin__section d-flex">
        <Slidebar />
        <div className="main__content">
            <h1>Tài khoản</h1>
            {/* <div className="select__actions">
            <div className="select__actions--datetime d-flex flex-column">
                <label class="mb-1">Thời gian</label>
                <LocalizationProvider dateAdapter={AdapterDayjs}>
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
            </div> */}
            {/* table list product */}
            {/* form add product */}
            <div className="apply-form-component">
            <form action="" className="simple_form new_product">
                <div className="row w-100">
                <div class="col-md-2 description--label">
                    <h3>Mô tả</h3>
                </div>
                <div className="col-md-8 description--info">
                    <div className="form-group string required candidate_name">
                    <label
                        className="string required control-label"
                        for="candidate_name"
                    >
                        Tên người dùng <abbr title="required">*</abbr>
                    </label>
                    <input
                        class="string required form-control"
                        required
                        type="text"
                        name="name"
                        value={user.name}
                        onChange={(e) => {
                        handleChange(e)
                        }}
                    />
                    </div>
                    <div className="form-group string required candidate_name">
                    <label
                        className="string required control-label"
                        for="candidate_name"
                    >
                        Username <abbr title="required">*</abbr>
                    </label>
                    <input
                        class="string required form-control"
                        required
                        type="text"
                        name="name"
                        value={user.username}
                        onChange={(e) => {
                        handleChange(e)
                        }}
                        readOnly
                    />
                    </div>
                    <div className="form-group string required candidate_name">
                    <label
                        className="string required control-label"
                        for="candidate_name"
                    >
                        Vai trò <abbr title="required">*</abbr>
                    </label>
                    <Form.Select
                        aria-label="Default select example"
                        className="mr-3"
                        name="role"
                        onChange={(e) => {
                        handleChange(e)
                        }}
                        value={user.role}
                    >
                        <option value="admin">Quản lý</option> 
                        <option value="staff">Nhân viên</option> 
                        <option value="user">Khách hàng</option> 
                    </Form.Select>
                    </div>
                    <div className="row">
                        <div className="col-6">
                            <div className="form-group string required candidate_name">
                            <label
                                className="string required control-label"
                                for="candidate_name"
                            >
                                Ngày sinh <abbr title="required">*</abbr>
                            </label>
                            <input
                                class="string required form-control"
                                required
                                type="date"
                                name="date_of_birth"
                                value={user.date_of_birth}
                                onChange={(e) => {
                                handleChange(e)
                                }}
                            />
                            </div>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-6">
                            <div className="form-group string required candidate_name">
                            <label
                                className="string required control-label"
                                for="candidate_name"
                            >
                                Địa chỉ <abbr title="required">*</abbr>
                            </label>
                            <input
                                class="string required form-control"
                                required
                                type="text"
                                name="address"
                                value={user.address}
                                onChange={(e) => {
                                handleChange(e)
                                }}
                            />
                            </div>
                        </div>
                        <div className="col-6">
                            <div className="form-group string required candidate_name">
                            <label
                                className="string required control-label"
                                for="candidate_name"
                            >
                                Số điện thoại <abbr title="required">*</abbr>
                            </label>
                            <input
                                class="string required form-control"
                                required
                                type="text"
                                name="phone"
                                value={user.phone}
                                onChange={(e) => {
                                handleChange(e)
                                }}
                            />
                            </div>
                        </div>
                    </div>
                </div>
                </div>
                <div className="row w-100">
                <div className="form-group form-submit">
                    <button type="submit" class="btn select__action--add" onClick={e => handleSubmit(e)}>
                    Lưu
                    </button>
                </div>
                </div>
                <ModalBox show={isModal} handleClose={(e) => closeModal(e)}>
                    <h2>Đã xảy ra lỗi</h2>
                </ModalBox>
            </form>
            </div>
        </div>
        </div>
    </Helmet>
    );
}

export default CustomerDetail