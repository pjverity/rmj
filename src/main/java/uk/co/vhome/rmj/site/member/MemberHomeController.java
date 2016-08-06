package uk.co.vhome.rmj.site.member;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import uk.co.vhome.rmj.services.UserService;

@Controller
@RequestMapping("/member")
@SuppressWarnings("unused")
public class MemberHomeController
{
	private static final Logger LOGGER = LogManager.getLogger();

	private final UserService userService;

	public MemberHomeController(UserService userService)
	{
		this.userService = userService;
	}

	@RequestMapping(method = RequestMethod.GET)
	String getIndex()
	{
		LOGGER.traceEntry();

		return LOGGER.traceExit("/jsp/member/index");
	}

}
