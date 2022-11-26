import React, { useRef, useState, useEffect } from "react";
import Helmet from "../../../components/Helmet/Helmet";
import SlideBar from "../../../components/UI/slider/SlideBar";
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

function EditProduct() {
    const {id} = useParams()
    const navigate = useNavigate()
    const [isModal, setIsModal] = useState(false);
    const [categories, setCategories] = useState([])
    const [product, setProduct] = useState({})

    const handleChange = async (event) => {
        setProduct({ ...product, [event.target.name]: event.target.value });
    };

    const closeModal = (e) => {
        setIsModal(false);
    };

    const getProductDetail = async () => {
        await fetch(`http://localhost:8000/api/product/${id}`)
            .then((res) => res.json())
            .then((data) => {
            setProduct(data)
        })
    }

    let getCategories = async () => {
        let response = await fetch("http://localhost:8000/api/category");
        let data = await response.json();
        setCategories(data);
      };

    useEffect(() => {
        getProductDetail()
        getCategories()
    }, [])

    const handleSubmit = async (e) => {
        e.preventDefault();
        await fetch(`http://localhost:8000/api/product/${id}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `jwt=${Cookies.get('jwt')}`
            },
            credentials: 'include',
            body: JSON.stringify(product)
        }).then((response) => {
            console.log(response.status);
            if (response.status === 202) {
                navigate('/admin/products')
            } else {
                setIsModal(true)
            }
        })
      }

    return (
        <Helmet title="AdminPage">
            <div className="admin__section d-flex">
            <SlideBar />
            <div className="main__content">
                <h1>Sửa sản phẩm</h1>
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
                    <div class="col-md-4 description--label">
                        <h3>Mô tả sản phẩm</h3>
                        <p>Những thông tin cơ bản sản phẩm</p>
                    </div>
                    <div className="col-md-8 description--info">
                        <div className="form-group string required candidate_name">
                        <label
                            className="string required control-label"
                            for="candidate_name"
                        >
                            Tên sản phẩm <abbr title="required">*</abbr>
                        </label>
                        <input
                            class="string required form-control"
                            required
                            type="text"
                            placeholder="Your full name"
                            name="name"
                            value={product.name}
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
                            Loại sản phẩm <abbr title="required">*</abbr>
                        </label>
                        <Form.Select
                            aria-label="Default select example"
                            className="mr-3"
                            name="category"
                            onChange={(e) => {
                            handleChange(e)
                            }}
                            value={product.category}
                        >
                            <option>Chọn loại sản phẩm</option>
                            {categories.map((item) => {return <option key={item.id} value={item.id}>{item.name}</option>} )}  
                        </Form.Select>
                        </div>
                        <div className="row">
                        <div className="col-6">
                            <div className="form-group string required candidate_name">
                            <label
                                className="string required control-label"
                                for="candidate_name"
                            >
                                Giá sản phẩm <abbr title="required">*</abbr>
                            </label>
                            <input
                                class="string required form-control"
                                required
                                type="number"
                                placeholder="Giá sản phẩm"
                                name="price"
                                value={product.price}
                                onChange={(e) => {
                                handleChange(e)
                                }}
                            />
                            </div>
                        </div>
                        {/* <div className="col-6">
                            <div className="form-group string required candidate_name">
                            <label
                                className="string required control-label"
                                for="candidate_name"
                            >
                                Số lượng sản phẩm <abbr title="required">*</abbr>
                            </label>
                            <input
                                class="string required form-control"
                                required
                                type="number"
                                placeholder="Nhập số lượng sản phẩm"
                                name="quantity"
                            />
                            </div>
                        </div> */}
                        </div>

                        <div className="form-group file_preview optional product_photo">
                        <label
                            className="file_preview optional control-label"
                            for="photo-file"
                        >
                            Hình ảnh
                        </label>
                        <div class="file-preview">
                            <div class="img-container">
                            <div class="file-type"></div>
                            </div>
                            <div class="footer"></div>
                            <div class="btn-delete delete-btn ion-android-delete"></div>
                        </div>
                        <button name="button" type="button">
                            Add file
                        </button>
                        <div className="hidden-field"></div>
                        <span className="help-block">
                            We accept PNG, JPG, and JPEG files
                        </span>
                        </div>
                    </div>
                    </div>
                    <div className="row w-100">
                    <div class="col-md-4 description--label">
                        <h3>Thông tin sả/api/product/31n phẩm</h3>
                        <p>Mô tả nguyên liệu sản phẩm</p>
                    </div>
                    <div className="col-md-8 description--info">
                        <div className="form-group string required candidate_name">
                        <label
                            className="string required control-label"
                            for="candidate_name"
                        >
                            Mô tả <abbr title="required">*</abbr>
                        </label>
                        <textarea
                            rows="5"
                            class="text optional form-control"
                            name="description"
                            id="candidate_cover_letter"
                            style={{ height: "10rem" }}
                            onChange={(e) => {
                            handleChange(e)
                            }}
                            value={product.description}
                        ></textarea>
                        </div>
                    </div>
                    </div>
                    <div className="row w-100">
                    <div className="form-group form-submit">
                        <button type="submit" class="btn select__action--add" onClick={e => handleSubmit(e)}>
                        Thêm sản phẩm
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

export default EditProduct