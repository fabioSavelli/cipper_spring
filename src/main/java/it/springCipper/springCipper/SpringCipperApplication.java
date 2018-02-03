package it.springCipper.springCipper;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.web.servlet.view.UrlBasedViewResolver;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;

@SpringBootApplication
public class SpringCipperApplication {

	public static void main(String[] args) {
		SpringApplication.run(SpringCipperApplication.class, args);
	}
	
	@Bean
	public TilesConfigurer tilesConfigurer() {
		TilesConfigurer tilesConfigurer = new TilesConfigurer();

		String[] defs = { "/WEB-INF/tiles.xml" };

		tilesConfigurer.setDefinitions(defs);

		return tilesConfigurer;
	}
	
	@Bean
	public UrlBasedViewResolver tilesViewResolver() {
		UrlBasedViewResolver tilesViewResolver = new UrlBasedViewResolver();

		tilesViewResolver.setViewClass(TilesView.class);

		return tilesViewResolver;
	}
}
