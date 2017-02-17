<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html lang="en">

<c:set var="pageTitleSuffix" value="Reigate Mens Joggers"/>

<%@include file="../head.jsp" %>

<body>

<%@include file="../navigation.jsp" %>

<div class="container">

	<div class="text-center">
		<img class="img-responsive center-block" src="/images/rmj-full-logo.jpg" srcset="/images/rmj-full-logo@2x.jpg 2x"/>
		<p class="lead">
			It's got to be better than sitting on the sofa right?<br/>Escape that stuffy office and come for a run - you won't regret it!
		</p>
		<security:authorize access="!isAuthenticated()">
		<c:choose>
			<c:when test="${registrationServiceAvailable}">
				<p>
				<button type="button" class="btn btn-success btn-lg" data-toggle="modal" data-target="#signupModal">Sign Up!</button>
				</p>
			</c:when>
			<c:otherwise>
				<div class="alert alert-danger">New registrations currently unavailable</div>
			</c:otherwise>
		</c:choose>
		</security:authorize>
	</div>

</div>

<hr/>

<div class="container">
	<div class="row">
		<div class="col-sm-12">
		<p>This is a mixed ability session so if you are returning to running, trying running for the first time or wanting to increase your running there is something for
			everyone.</p>
		<p>It's a fun, friendly group where no one gets left behind. We will have a real variety of sessions from hills work, speed work, interval training and steady runs. We also will
			have social events, races and plan special events.</p>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-4">
			<h3>When?</h3>
			<p>Every Tuesday 7.30pm - 8.30pm</p>
		</div>
		<div class="col-sm-4">
			<h3>Where?</h3>
			<p>Our coach Richard will be waiting for you at St Bedes School. Carlton Road, Redhill. Please do come along!</p>
		</div>
		<div class="col-sm-4">
			<h3>How Much?</h3>
			<p>First session FREE! Sessions following are £5 and can be bought in blocks of 10</p>
		</div>
	</div>

	<hr/>

	<div class="row">
		<div class="media">
			<div class="media-left" style="text-align: center;">
				<c:url value="/organiser/profile" var="organiserProfilelUrl"/>
				<a href="${organiserProfilelUrl}">
					<img src="/images/Richard.png" alt="Coach Richard">Richard Feist
				</a>
			</div>
			<div class="media-body">
				<h3 class="media-heading">RMJ Coach</h3>
				<p>With many years of sports coaching, you'll be in good hands with RMJ's experienced coach, Richard.</p>

				<p>Whether you're an absolute newbie needing that kick start to get you on your way to a healthier lifestyle, or
					a hardened all weather runner, Richard will be able to guide you towards achieving your goals.</p>

				<p>Still not convinced? Check out Richard's <a href="${organiserProfilelUrl}">profile</a> to find out more.</p>
			</div>
		</div>
	</div>
</div>

<hr/>

<div class="container-fluid small">
	<div class="row">
		<div class="col-sm-6">
			<small class="text-muted">Not a man? <a href="http://www.reigateladiesjoggers.co.uk">www.reigateladiesjoggers.co.uk</a></small>
		</div>
		<div class="col-sm-6 text-right">
			<small class="text-muted">Under construction. © Paul Verity (2017) <a href="https://github.com/pjverity/rmj" class="social-buttons small"><i
							class="fa fa-github fa-fw"></i></a></small>
		</div>
	</div>
</div>

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
        crossorigin="anonymous"></script>

<security:authorize access="!isAuthenticated()">
	<%@include file="../signup-dialog.jsp" %>
</security:authorize>

</body>

</html>
