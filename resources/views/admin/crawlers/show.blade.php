@extends('layouts.admin')

@section('title', trans('crawlers.crawler') . ' - ' . $crawler->store->name)

@section('content')

<div class="row">
	<div class="col-md-12">
		@if ($crawler->list_state == 'RUNNING')
		<div class="alert alert-warning">
			{{ trans('crawers.list_crawler_currently_running') }}
		</div>
		@endif
		@if ($crawler->cards_state == 'RUNNING')
		<div class="alert alert-warning">
			{{ trans('crawers.cards_crawler_currently_running') }}
		</div>
		@endif
	</div>
</div>

<div class="row">
	<div class="col-md-6">
		<a href="{{ route('admin.crawlers.edit', $crawler->id) }}" class="btn btn-primary">{{ trans('app.edit') }}</a>
		<a href="{{ route('admin.crawlers.cards-data.index', $crawler->id) }}" class="btn btn-primary">{{ trans('cards_data.index') }}</a>
	</div>
	<div class="col-md-6 text-right">
		@if ($crawler->list_state != 'RUNNING')
			<a href="{{ route('admin.crawlers.list-toggle', $crawler) }}" class="btn btn-{{ $crawler->list_state == 'ON' ? 'success' : 'danger' }}">
				{{ trans($crawler->list_state == 'ON' ? 'crawlers.list_parsing_on' : 'crawlers.list_parsing_off') }}
			</a>
		@endif
			@if ($crawler->cards_state != 'RUNNING')
			<a href="{{ route('admin.crawlers.cards-toggle', $crawler) }}" class="btn btn-{{ $crawler->cards_state == 'ON' ? 'success' : 'danger' }}">
				{{ trans($crawler->cards_state == 'ON' ? 'crawlers.cards_parsing_on' : 'crawlers.cards_parsing_off') }}
			</a>
		@endif
		<a href="{{ route('admin.crawlers.run.list', $crawler->id) }}" class="btn btn-primary">{{ trans('crawlers.run_list') }}</a>
		<a href="{{ route('admin.crawlers.run.cards', $crawler->id) }}" class="btn btn-primary">{{ trans('crawlers.run_cards') }}</a>
	</div>
</div>

<div class="row">
	<div class="col-md-6">
		<h2>{{ trans('crawlers.general_configuration') }}</h2>

		<dl>
			<dt>{{ trans('stores.store') }}</dt>
			<dd>{{ $crawler->store->name }}</dd>

			<dt>{{ trans('crawlers.list_url') }}</dt>
			<dd>
				<a href="{{ $crawler->list_url }}" target="_blank">{{ $crawler->list_url }}</a>
			</dd>

			<dt>{{ trans('crawlers.list_frequency') }}</dt>
			<dd><code>{{ $crawler->list_frequency }}</code></dd>

			<dt>{{ trans('crawlers.last_list_completion') }}</dt>
			<dd>
				<span class="text-{{ $crawler->last_list_run_success ? 'success' : 'danger' }}">
					{{ $crawler->last_list_completion ?? trans('crawlers.never') }}
				</span>
			</dd>

			<dt>{{ trans('crawlers.list_state') }}</dt>
			<dd>
				<span class="text-{{ ['RUNNING' => 'warning', 'ON' => 'success', 'OFF' => 'danger'][$crawler->list_state] }}">
					{{ $crawler->list_state }}
				</span>
			</dd>

			<dt>{{ trans('crawlers.cards_frequency') }}</dt>
			<dd><code>{{ $crawler->cards_frequency }}</code></dd>

			<dt>{{ trans('crawlers.last_cards_completion') }}</dt>
			<dd>
				<span class="text-{{ $crawler->last_cards_run_success ? 'success' : 'danger' }}">
					{{ $crawler->last_cards_completion ?? trans('crawlers.never') }}
				</span>
			</dd>

			<dt>{{ trans('crawlers.cards_state') }}</dt>
			<dd>
				<span class="text-{{ ['RUNNING' => 'warning', 'ON' => 'success', 'OFF' => 'danger'][$crawler->cards_state] }}">
					{{ $crawler->cards_state }}
				</span>
			</dd>
		</dl>
	</div>
	<div class="col-md-6">
		<h2>{{ trans('crawlers.parsing_configuration') }}</h2>

		<dl>
			<dt>{{ trans('crawlers.individual_selector') }}</dt>
			<dd><code>{{ $crawler->individual_selector ?? 'null' }}</code></dd>

			<dt>{{ trans('crawlers.url_selector') }}</dt>
			<dd><code>{{ $crawler->url_selector ?? 'null' }}</code></dd>

			<dt>{{ trans('crawlers.brand_selector') }}</dt>
			<dd><code>{{ $crawler->brand_selector ?? 'null' }}</code></dd>

			<dt>{{ trans('crawlers.name_selector') }}</dt>
			<dd><code>{{ $crawler->name_selector ?? 'null' }}</code></dd>

			<dt>{{ trans('crawlers.description_selector') }}</dt>
			<dd><code>{{ $crawler->description_selector ?? 'null' }}</code></dd>

			<dt>{{ trans('crawlers.in_stock_selector') }}</dt>
			<dd><code>{{ $crawler->in_stock_selector ?? 'null' }}</code></dd>

			<dt>{{ trans('crawlers.price_selector') }}</dt>
			<dd><code>{{ $crawler->price_selector ?? 'null' }}</code></dd>
		</dl>
	</div>
</div>

@if (!empty(session('output')))
<div class="row">
	<div class="col-md-12">
		<h2>{{ trans('crawlers.execution_output') }}</h2>

		<pre>{{ session('output') }}</pre>
	</div>
</div>
@endif

@endsection