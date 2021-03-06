package com.ironyard.controller;

import com.ironyard.data.Movie;
import com.ironyard.repo.MovieRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * Created by jasonskipper on 2/7/17.
 */
@Controller
public class MovieController {

    @Autowired
    MovieRepo movieRepo;


    @RequestMapping(path = "/secure/movie/delete", method = RequestMethod.GET)
    public String deleteMovie(Model mapOfDataForJsp, @RequestParam Long id){
        movieRepo.delete(id);
        // find by
        mapOfDataForJsp.addAttribute("delete_success", "Movie Deleted.");
        return "forward:/secure/movies";
    }


    @RequestMapping(path = "/secure/movie/select", method = RequestMethod.GET)
    public String selectMovieForEdit(Model mapOfDataForJsp, @RequestParam Long id){
        Movie selectedMovie = movieRepo.findOne(id);
        mapOfDataForJsp.addAttribute("selectedMovie", selectedMovie);
        String dest = "/secure/create";
        return dest;
    }

    @RequestMapping(path = "/secure/movie/create", method = RequestMethod.POST,
            consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    public String createMovie(Model dataToJsp, Movie myFavoriteMove){
        String dest = "/secure/create";
        // save to database
        movieRepo.save(myFavoriteMove);

        // if successful save, add message
        if(myFavoriteMove.getId()>0) {
            dataToJsp.addAttribute("succes_movie_create_msg",
                    String.format("Movie '%s' was created!", myFavoriteMove.getName()));
        }
        return dest;
    }

    @RequestMapping(path = "/secure/movies")
    public String listMovies(@RequestParam(value = "page", required = false) Integer page,
                             @RequestParam(value = "size", required = false) Integer size,
                            Model model){

        String destination = "home";
        if(page == null){
            page = 0;
        }
        if(size == null){
            size = 2;
        }
        Sort s = new Sort(Sort.Direction.DESC, "name");
        PageRequest pr = new PageRequest(page, size, s);

        Page<Movie> found = movieRepo.findAll(pr);
        // put list into model
        model.addAttribute("moviePage", found);
        // go to jsp
        return destination;
    }
}



















