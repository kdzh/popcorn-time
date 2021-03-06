<div class="fa fa-times close-icon"></div>
<div class="tv-poster">
	<div data-bgr="<%= images.fanart %>" class="tv-poster-background"><div class="tv-poster-overlay"></div></div>
	<div data-bgr="<%= images.poster %>" class="tv-cover"></div>

	<div class="tv-meta-data">
		<div class="tv-title"><%= title %></div>
		<div class="tv-duration"><%= year %></div>
		<div class="tv-dot"></div>
		<div class="tv-genre"><%= runtime %> min</div>
		<div class="tv-dot"></div>
		<div class="tv-status"><%= status !== undefined ? i18n.__(status) : "N/A" %></div>
		<div class="tv-dot"></div>
		<div class="tv-num-episodes"><%= i18n.__(genres[0]) %></div>
		<div class="tv-dot"></div>
		<% p_rating = Math.round(rating.percentage) / 20; // Roundoff number to nearest 0.5 %>
		<div data-toggle="tooltip" data-placement="right" title="<%= Math.round(rating.percentage) / 10 %> /10" class="star-container-tv">

		<% for (var i = 1; i <= Math.floor(p_rating); i++) { %>
			<i class="star"><svg viewbox="0 0 100 100" width="16px" height="16px"><path d="M71.686,85.706L69,60l16.982-17.541L62,39L50.001,13.98L38,39l-23.982,3.284L31,60l-2.692,25.676L49.98,72 c0.017,0,0.028,0,0.049,0L71.686,85.706z"/></svg></i>
		<% }; %>
		<% if (p_rating % 1 > 0) { %>
			<i class="star-half"><svg viewbox="0 0 100 100" width="16px" height="16px"><path d="M71.686,85.706L69,60l16.982-17.541L62,39L50.001,13.98L38,39l-23.982,3.284L31,60l-2.692,25.676L49.98,72 c0.017,0,0.028,0,0.049,0L71.686,85.706z"/></svg></i>
		<% }; %>
		<% for (var i = Math.ceil(p_rating); i < 5; i++) { %>
			<i class="star-empty"><svg viewbox="0 0 100 100" width="16px" height="16px"><path d="M71.686,85.706L69,60l16.982-17.541L62,39L50.001,13.98L38,39l-23.982,3.284L31,60l-2.692,25.676L49.98,72 c0.017,0,0.028,0,0.049,0L71.686,85.706z"/></svg></i>
		<% }; %>
		</div>
		<% if (synopsis.length > 776) { var synopsis = synopsis.substring(0, 776) + "..."; } %>
		<div class="tv-overview"><%= synopsis %></div>
	</div>
</div>

<div class="episode-base">
	<div class="episode-info">
		<div class="episode-info-title"></div>
		<div class="episode-info-number"></div>
		<div data-toggle="tooltip" data-placement="left" title="<%=i18n.__("Health Unknown") %>" class="fa fa-circle health-icon None"></div>
		<div class="episode-info-date"></div>
		<div class="episode-info-description"></div>
		<div class="show-quality-container">
			<div class="quality-selector">
				<div class="q480">480p</div>
				<div class="q720">720p</div>
				<div class="quality switch white">
					<input type="radio" name="switch" id="switch-hd-off" >
					<input type="radio" name="switch" id="switch-hd-on" checked >
					<span class="toggle"></span>
				</div>
			</div>
			<div class="quality-info"></div>
		</div>
		<div class="movie-btn-watch-episode startStreaming" data-torrent="" data-episodeid="">
			<div class="movie-watch-now"><%= i18n.__("Watch Now") %></div>
		</div>
	</div>

	<div class="display-base-title">
		<div class="episode-list-seasons"><%= i18n.__("Seasons") %></div>
		<div class="episode-list-episodes"><%= i18n.__("Episodes") %></div>
	</div>

	<div class="season-episode-container">
		<div class="tabs-base">
			<div class="tabs-seasons">
				<ul>
					<% var torrents = {};
					_.each(episodes, function(value, currentEpisode) {
						if (!torrents[value.season]) torrents[value.season] = {};
						torrents[value.season][value.episode] = value;
					});
					_.each(torrents, function(value, season) { %>
						<li class="tab-season" data-tab="season-<%=season %>">
							<a><%= i18n.__("Season") %>&nbsp;<%=season %></a>
						</li>
					<% }); %>
				</ul>
			</div>
			<div class="tabs-episodes">
				<% _.each(torrents, function(value, season) { %>
					<div class="tab-episodes season-<%=season %>">
						<ul>
							<% _.each(value, function(episodeData, episode) {
								var first_aired = '',
									q720 = '',
									q480 = '';

								if (episodeData.first_aired !== undefined) {
									first_aired = moment.unix(episodeData.first_aired).lang(Settings.language).format("LLLL");
								}
								if(episodeData.torrents["480p"]) {
									q480 = episodeData.torrents["480p"].url;
								}
								if(episodeData.torrents["720p"]) {
									q720 = episodeData.torrents["720p"].url;
								}

							%>
								<li class="tab-episode" data-id="<%=episodeData.tvdb_id %>">
									<a href="#" class="episodeData">
										<span><%=episodeData.episode %></span>
										<div><%=episodeData.title %></div>
									</a>
									
									<i id="watched-<%=episodeData.season%>-<%=episodeData.episode%>" class="fa fa-eye watched"></i>


									<!-- hidden template so we can save a DB query -->
									<div class="template-<%=episodeData.tvdb_id %>" style="display:none">
										<span class="title"><%=episodeData.title %></span>
										<span class="date"><%=first_aired %></span>
										<span class="season"><%=episodeData.season %></span>
										<span class="episode"><%=episodeData.episode %></span>
										<span class="overview"><%=episodeData.overview %></span>
										<span class="q480"><%=q480 %></span>
										<span class="q720"><%=q720 %></span>
									</div>
								</li>
							<% }); %>
						</ul>
					</div><!--End tabs-episode-->
				<% }); %>
			</div><!--End tabs-episode-base-->
		</div><!--End tabs_base-->
	</div><!--End season-episode-container-->
</div>