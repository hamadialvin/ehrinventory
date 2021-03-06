<%--
/**
* The contents of this file are subject to the OpenMRS Public License
* Version 1.0 (the "License"); you may not use this file except in
* compliance with the License. You may obtain a copy of the License at
* http://license.openmrs.org
*
* Software distributed under the License is distributed on an "AS IS"
* basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
* License for the specific language governing rights and limitations
* under the License.
*
* Copyright (C) OpenMRS, LLC.  All Rights Reserved.
*/
--%>
<%@ include file="/WEB-INF/template/include.jsp" %>

<openmrs:require privilege="Add/Edit mainstore" otherwise="/login.htm" redirect="/module/ehrinventory/main.form" />
<spring:message var="pageTitle" code="inventory.purchase.manager" scope="page"/>
<%@ include file="/WEB-INF/template/header.jsp" %>
<%@ include file="../includes/js_css.jsp" %>

<div style="width: 45%; float: left; margin-left: 4px; ">
<b class="boxHeader">Drug</b>
<div class="box">

<form method="post" id="purchaseOrder">
<br/>

<table class="box">
<tr><td><b>Drug Info</b></td></tr>
<tr>
		<td><spring:message code="ehrinventory.drug.category"/><em>*</em></td>
		<td>
			<select name="category" id="category" onchange="PURCHASE.onChangeCategory(this);"  style="width: 250px;">
				<option value=""><spring:message code="ehrinventory.pleaseSelect"/></option>
                <c:forEach items="${listCategory}" var="vCat">
                    <option value="${vCat.id}"  <c:if test="${vCat.id == categoryId }">selected</c:if> >${vCat.name}</option>
                </c:forEach>
   			</select>
		</td>
	</tr>
	<tr>
		<td><spring:message code="ehrinventory.drug.name"/><em>*</em></td>
		<td>
			<input type="text" id="itemName" name="itemName" onblur="PURCHASE.onBlur(this);" style="width:350px;"/>
		</td>
	</tr>
	<tr>
		<td><spring:message code="ehrinventory.drug.formulation"/><em>*</em></td>
		<td>
			<div id="divFormulation">
				<select id="formulation">
				
				</select>
			</div>
		</td>
	</tr>
</table>
<br/>
<table class="box">
	<tr>
		<td><spring:message code="ehrinventory.purchase.quantity"/><em>*</em></td>
		<td>
			<input type="text" id="quantity" name="quantity" />
		</td>
	</tr>
</table>
<br/>
<input type="submit" class="ui-button ui-widget ui-state-default ui-corner-all" value="<spring:message code="ehrinventory.purchase.addToSlip"/>">
<input type="button" class="ui-button ui-widget ui-state-default ui-corner-all" value="<spring:message code="ehrinventory.back"/>" onclick="ACT.go('purchaseOrderForGeneralStoreList.form');">
</form>
</div>
</div>
<!-- Purchase list -->
<div style="width: 53%; float: right; margin-right: 16px; ">
<b class="boxHeader">Purchase order for general store slip</b>
<div class="box">
<table class="box" width="100%" cellpadding="5" cellspacing="0">
	<tr>
	<th>S.No</th>
	<th><spring:message code="inventory.drug.category"/></th>
	<th><spring:message code="inventory.drug.name"/></th>
	<th><spring:message code="inventory.drug.formulation"/></th>
	<th><spring:message code="inventory.receiptDrug.quantity"/></th>
	</tr>
	<c:choose>
	<c:when test="${not empty listPurchase}">
	<c:forEach items="${listPurchase}" var="purchase" varStatus="varStatus">
	<tr class='${varStatus.index % 2 == 0 ? "oddRow" : "evenRow" } '>
		<td><c:out value="${(( pagingUtil.currentPage - 1  ) * pagingUtil.pageSize ) + varStatus.count }"/></td>
		<td>${purchase.drug.category.name} </td>	
		<td>${purchase.drug.name}</td>
		<td>${purchase.formulation.name}</td>
		<td>${purchase.quantity}</td>
		</tr>
	</c:forEach>
	
	</c:when>
	</c:choose>
</table>
<br/>
	<c:if  test="${not empty listPurchase}">
		<table class="box" width="100%" cellpadding="5" cellspacing="0">
		<tr>
			<td>
				<input type="button" value="<spring:message code="inventory.purchase.finish"/>" onclick="PURCHASE.processSlip('0');" />
				<input type="button" value="<spring:message code="inventory.purchase.clear"/>"  onclick="PURCHASE.processSlip('1');"/>
				<input type="button" value="<spring:message code="inventory.purchase.print"/>" onClick="PURCHASE.printDiv();" />
			</td>
		</tr>
		</table>
	</c:if>
</div>
</div>
<!-- PRINT DIV -->
<div  id="printDiv" style="display: none; margin: 10px auto; width: 981px; font-size: 1.5em;font-family:'Dot Matrix Normal',Arial,Helvetica,sans-serif;">        		

<center>
Purchase Order For General Store
</center>
<table border="1">
	<tr>
	<th>S.No</th>
	<th><spring:message code="inventory.drug.category"/></th>
	<th><spring:message code="inventory.drug.name"/></th>
	<th><spring:message code="inventory.drug.formulation"/></th>
	<th><spring:message code="inventory.purchase.quantity"/></th>
	</tr>
	<c:choose>
	<c:when test="${not empty listPurchase}">
	<c:forEach items="${listPurchase}" var="purchase" varStatus="varStatus">
	<tr class='${varStatus.index % 2 == 0 ? "oddRow" : "evenRow" } '>
		<td><c:out value="${(( pagingUtil.currentPage - 1  ) * pagingUtil.pageSize ) + varStatus.count }"/></td>
		<td>${purchase.drug.category.name} </td>	
		<td>${purchase.drug.name}</td>
		<td>${purchase.formulation.name}</td>
		<td>${purchase.quantity}</td>
		</tr>
	</c:forEach>
	</c:when>
	</c:choose>
</table>
<br/><br/><br/><br/><br/><br/>
<span style="float:right;font-size: 1.5em">Signature of Inventory Clerk/ Stamp</span>
</div>
<!-- END PRINT DIV -->   

 
<%@ include file="/WEB-INF/template/footer.jsp" %>