<?php if(!defined("APP_URL")){ die('Direct access not permitted');} ?>
<div class="container-fluid pl-0 pr-5 mr-5"  style="margin-top:-100px; position:fixed; z-index:996;">
    <div class="row">
        <div class="col-12" >
            <h2 class="text-center mb-2 m-0 text-info">Etapy formularza (<span id="headTitle"></span>):</h2>
        </div>
    </div>
    <div class="row">
        <div class="col-6 mb-0 mt-0" >
            <div class="btn pull-left mt-0" > 
                <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
                    <div class="btn-group" role="group">
                        <button class="btn btn-info text-white" type="button" id="showStages">Etapy</button>
                        <button type="button" class="btn  btn-info dropdown-toggle dropdown-toggle-split text-white" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                          <span class="sr-only">Toggle Dropdown</span>
                        </button>
                        <div class="dropdown-menu bg-info">
                            <a class="dropdown-item bg-info text-white" id="addStage" href="#">Dodaj</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-6 mb-0 mt-0" >
                <div class="input-group"><input type="text" class="form-control" placeholder="Szukaj..."  ><div class="input-group-append"><button class="btn btn-secondary" type="button" ><i class="fa fa-search" id="filterStages"></i></button></div>
                  </div>
                    <div class="form-group form-check-inline mt-0">
                    <label class="form-check-label">
                        <input type="checkbox" class="form-check-input" value="0" onclick="FormPart.hidden(this)">
                        <small class="text-secondary">Pokaż ukryte</small>
                    </label>
                    </div>
                    <div class="form-group form-check-inline mt-0 ">
                    <label class="form-check-label">
                        <input type="checkbox" class="form-check-input" value="0" onclick="FormPart.deleted(this)">
                        <small class="text-danger">Pokaż usunięte</small>
                    </label>
                    </div>
                    <div class="form-group form-check-inline mt-0 ">
                    <label class="form-check-label">
                        <input type="checkbox" class="form-check-input" value="0" onclick="FormPart.all(this)">
                        <small class="text-primary">Pokaż wszystkie</small>
                    </label>
                    </div>
            </div>
        </div>
    </div>
<!-- LEGEND -->
<div class="modal fade mb-0 pb-0 col-sm-12" id="legendDiv">
    <hr class="w-100"></hr>
        <small class="modal-title text-left text-secondary pl-1 pb-2" id="fieldModalLabel">Legenda:</small> 
            <ul class="text-secondary font-weight-normal small" style="list-style-type:square;">
                <li>A - litera alfabetu, C - cyfra</li>
                <li>Nazwa:</li>
                    <ul style="list-style-type:disc;">
                        <li>Musi się zacząć A</li>
                        <li>Min 3 znaki</li>
                        <li>Max 30 znaków</li>
                        <li>Może zawierać zawierać A,C,- </li>
                    </ul>
            </ul>
</div>    
<!-- END LEGEND --><?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

