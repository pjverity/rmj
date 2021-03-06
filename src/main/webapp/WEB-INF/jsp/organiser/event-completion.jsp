<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%--@elvariable id="row" type="uk.co.vhome.clubbed.web.site.organiser.EventCompletionFormRow"--%>
<%--@elvariable id="eventCompletionFormObject" type="uk.co.vhome.clubbed.web.site.organiser.EventCompletionFormObject"--%>

<!DOCTYPE html>
<html lang="en">

<c:set var="pageTitleSuffix" value="Run Completion"/>

<head>
	<%@ include file='../head-common.jsp' %>
</head>

<body>

<%@include file="../navigation.jsp" %>

<div class="container pt-3">

	<form:form id="registrationForm" modelAttribute="eventCompletionFormObject">


		<%-- Completion confirmation dialog --%>

	<div id="confirmModal" class="modal" tabindex="-1" role="dialog" data-backdrop="static">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Confirm Run Completed</h5>
				</div>
				<div class="modal-body">
					<spring:message code="ui.event-completion.Confirm"/>
				</div>
				<div class="modal-footer">
					<form:button class="btn btn-secondary" data-dismiss="modal">Cancel</form:button>
					<input type="submit" class="btn btn-primary" value="Confirm"/>
				</div>
			</div>
		</div>
	</div>


		<%-- Runner selection --%>

	<div class="form-group row">
		<div class="col">

			<div class="card">
				<h6 class="card-header">Select Runners</h6>

				<table class="table table-sm my-0">
					<thead>
					<tr>
						<th>Member</th>
						<th>Finished?</th>
						<th>Token Balance</th>
					</tr>
					</thead>

					<tbody>
					<c:forEach var="row" items="${eventCompletionFormObject.rows}" varStatus="vs">
						<tr>
							<td>
								<a href="mailto:${row.userDetailsEntity.userEntity.username}">${row.userDetailsEntity.firstName}&nbsp;${row.userDetailsEntity.lastName}</a>
							</td>
							<td><form:checkbox cssClass="checkbox" path="rows[${vs.index}].present" name="present" value="${row.present}"/></td>
							<td>${row.userDetailsEntity.balance == null ? 0 : row.userDetailsEntity.balance}</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>

			</div>
		</div>
	</div>


		<%-- Run Date Selection --%>

	<div class="form-group row">

		<div class="col-12 col-md-5 ${empty events ? 'has-danger' : ''}">
			<label for="runDateTimeSelect" class="col-form-label">Completion Date</label>
			<c:choose>
				<c:when test="${empty events}">
					<c:url value='/organiser/event-scheduling' var="url"/>
					<div id="runDateTimeSelect" class="form-control-static">
						<spring:message code="ui.event-completion.NoEvents" arguments="${url}"/>
					</div>
				</c:when>
				<c:otherwise>
					<div class="input-group">
						<form:select id="runDateTimeSelect" cssClass="custom-select form-control" path="event">
							<form:options items="${events}" itemLabel="eventDateTimeFullText"/>
						</form:select>
						<span class="input-group-btn">
			        <button class="btn btn-danger" type="button" onclick="cancelEvent('organiser/event-scheduling?cancelEventId=')">Cancel</button>
						</span>
					</div>
				</c:otherwise>
			</c:choose>
		</div>


			<%-- Run Distance Selection --%>

		<div id="distanceGroup" class="col-6 col-md-2 ${empty events ? 'has-danger' : ''}">

			<label for="distance" class="col-form-label">Distance</label>
			<div class="input-group">
				<form:input cssClass="form-control" id="distanceInput" path="distance"/>
				<div class="input-group-addon p-0">
					<form:select path="metric" class="custom-select border-0" style="width: 100%; background-color: transparent" id="metricSelection">
						<form:option value="MILES">Miles</form:option>
						<form:option value="KILOMETERS">Km</form:option>
					</form:select>
				</div>
			</div>
		</div>


			<%-- Completion button --%>

		<div class="col-6 col-md-4">
			<label class="col-form-label hidden-down">&nbsp;</label>
			<div class="input-group" >

			<button type="button" id="completeButton" class="btn btn-success" data-target="#confirmModal" data-toggle="modal">
				<span id="runnerCountBadge" class="badge badge-pill badge-light">0</span>
				Complete Run
			</button>
			</div>
		</div>

	</div>


		<%-- Errors Alert Panel --%>

	<spring:hasBindErrors name="eventCompletionFormObject">
	<div class="form-group row">
		<div class="col">

			<div class="alert alert-danger" role="alert">
				<span><strong>Invalid input</strong></span>
				<ul>
					<c:forEach var="error" items="${errors.fieldErrors}">
						<li>${error.field}&nbsp;${error.defaultMessage}</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
	</spring:hasBindErrors>

	</form:form>

</body>

<script id="event-completion-script" type="text/javascript" data-url="<c:url value='/'/>">

	const contextPath = $('#event-completion-script').attr('data-url');

	const $runDateTimeSelect = $('#runDateTimeSelect');
	const $metricSelection = $('#metricSelection');
	const $completeButton = $('#completeButton');
	const $runnerCountBadge = $('#runnerCountBadge');
	const $distanceGroup = $('#distanceGroup');
	const $distanceInput = $('#distanceInput');

	var runnerCount = $('form input:checkbox:checked').length;
	var runSelected = $runDateTimeSelect.find(':selected').length > 0;
	var distanceEntered = $.isNumeric($distanceInput.val());

	$(function () {
		$runnerCountBadge.text(runnerCount);
	  $distanceGroup.toggleClass('has-danger', !distanceEntered);
	  updateCompleteButtonState();
  });

  $('form input:checkbox').on('click', function () {
	  runnerCount += this.checked ? 1 : -1;
	  $runnerCountBadge.text(runnerCount);
	  updateCompleteButtonState();
  });

  $distanceInput.on('keyup', function () {
	  distanceEntered = $.isNumeric($(this).val());
	  $distanceGroup.toggleClass('has-danger', !distanceEntered);

	  updateCompleteButtonState();
  });

	$('#confirmModal').on('show.bs.modal', function () {
		const distance = $distanceInput.val();
		const metric = $metricSelection.find(':selected').text();
		const dateTime = $runDateTimeSelect.find(':selected').text();

		$('#confirmRunDateTime').text(dateTime);
		$('#confirmRunnerCount').html('<strong>' + runnerCount + '</strong> ' + (runnerCount === 1 ? 'person' : 'people'));
		$('#confirmRunDistance').html('<strong>' + distance + ' ' + metric + '</strong> ');
	});

	function updateCompleteButtonState() {
		const formIncomplete = !runSelected || runnerCount === 0 || !distanceEntered;
		if (formIncomplete) {
			$completeButton.attr('disabled', true);
		}
		else {
			$completeButton.removeAttr('disabled');
		}
	}

	function cancelEvent(url) {
		window.location = contextPath + url + $runDateTimeSelect.find(':selected').val();
	}

</script>

</html>