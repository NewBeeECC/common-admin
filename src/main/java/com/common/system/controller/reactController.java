package com.common.system.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by LandSnow-pc on 2017-07-06.
 */
@Controller
@RequestMapping(value = "react")
public class reactController extends BaseController{

    @RequestMapping(value = "index",method = RequestMethod.GET)
    public ModelAndView index(ModelAndView modelAndView){
        modelAndView.setViewName("/system/react/index");
        return modelAndView;
    }
}
