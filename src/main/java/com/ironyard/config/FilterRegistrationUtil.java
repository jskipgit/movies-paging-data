package com.ironyard.config;

import com.ironyard.filter.AuthFilter2;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Created by jasonskipper on 2/7/17.
 */
@Configuration
public class FilterRegistrationUtil {
    @Bean
    public FilterRegistrationBean mvcSecutiryFilter() {
        FilterRegistrationBean registration = new FilterRegistrationBean(new AuthFilter2());
        registration.addUrlPatterns("/secure/*");
        return registration;
    }
}
