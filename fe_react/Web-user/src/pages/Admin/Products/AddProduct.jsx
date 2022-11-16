import React, { useRef, useState, useEffect } from "react";
import Helmet from "../../../components/Helmet/Helmet";
import AdminSection from "../../../components/UI/admin-section/AdminSection";
import {
  Form,
  Button,
  FormGroup,
  FormControl,
  ControlLabel,
} from "react-bootstrap";

//date time picker
import TextField from "@mui/material/TextField";
import { AdapterDayjs } from "@mui/x-date-pickers/AdapterDayjs";
import { LocalizationProvider } from "@mui/x-date-pickers/LocalizationProvider";
import { DatePicker } from "@mui/x-date-pickers/DatePicker";

const AddProduct = () => {
  //date time picker
  const [value, setValue] = React.useState(null);

  return (
    <div className="main__content">
      <h1>Thêm sản phẩm</h1>
      <div className="select__actions">
        {/* date time picker */}
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
      </div>
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
                >
                  <option>Chọn loại sản phẩm</option>
                  <option value="1">Rice</option>
                  <option value="2">chiken</option>
                  <option value="3">Bugur</option>
                  <option value="4">Drink</option>
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
                    />
                  </div>
                </div>
                <div className="col-6">
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
                </div>
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
              <h3>Thông tin sản phẩm</h3>
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
                  name="candidate[cover_letter]"
                  id="candidate_cover_letter"
                  style={{ height: "10rem" }}
                ></textarea>
              </div>
            </div>
          </div>
          <div className="row w-100">
            <div className="form-group form-submit">
              <button type="submit" class="btn select__action--add">
                Thêm sản phẩm
              </button>
            </div>
          </div>
        </form>
      </div>
    </div>
  );
};

export default AddProduct;
