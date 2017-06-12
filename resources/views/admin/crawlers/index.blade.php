@extends('layouts.admin')

@section('title', trans('cards.index'))

@section('content')

<div class="row">
	<div class="col-md-9">
	</div>
	<div class="col-md-3 text-right">
		<a href="{{ route('admin.crawlers.create') }}" class="btn btn-primary">{{ trans('crawlers.create') }}</a>
	</div>
</div>

<div class="row">
	<div class="col-md-12">
		<table class="table table-striped table-hover table-condensed">
			<thead>
				<th>{{ trans('stores.store') }}</th>
				<th>{{ trans('crawlers.list_url') }}</th>
				<th>{{ trans('crawlers.list_frequency') }}</th>
				<th>{{ trans('crawlers.last_list_completion') }}</th>
				<th>{{ trans('crawlers.list_state') }}</th>
				<th>{{ trans('crawlers.cards_frequency') }}</th>
				<th>{{ trans('crawlers.last_cards_completion') }}</th>
				<th>{{ trans('crawlers.cards_state') }}</th>
				<th>{{ trans('crawlers.run') }}</th>
				<th>{{ trans('app.edit') }}</th>
				<th>{{ trans('app.delete') }}</th>
			</thead>
			<tbody>
			@foreach ($crawlers as $crawler)
				<tr>
					<td>
						{{ $crawler->store->name }}
					</td>
					<td>
						<span title="{{ $crawler->list_url }}" onclick="window.prompt('Copy to clipboard: Ctrl + C', '{{ $crawler->list_url }}');">
							Click for URL
						</span>
					</td>
					<td>
						{{ $crawler->list_frequency }}
					</td>
					<td>
						<span class="text-{{ $crawler->last_list_run_success ? 'success' : 'danger' }}">
							{{ $crawler->last_list_completion ?? trans('crawlers.never') }}
						</span>
					</td>
					<td>
						<a href="{{ $crawler->list_state != 'RUNNING' ? route('admin.crawlers.list-toggle', $crawler) : '' }}">
							<span class="text-{{ ['RUNNING' => 'warning', 'ON' => 'success', 'OFF' => 'danger'][$crawler->list_state] }}">
								{{ $crawler->list_state }}
							</span>
						</a>
					</td>
					<td>
						{{ $crawler->cards_frequency }}
					</td>
					<td>
						<span class="text-{{ $crawler->last_cards_run_success ? 'success' : 'danger' }}">
							{{ $crawler->last_cards_completion ?? trans('crawlers.never') }}
						</span>
					</td>
					<td>
						<a href="{{ $crawler->cards_state != 'RUNNING' ? route('admin.crawlers.cards-toggle', $crawler) : '' }}">
							<span class="text-{{ ['RUNNING' => 'warning', 'ON' => 'success', 'OFF' => 'danger'][$crawler->cards_state] }}">
								{{ $crawler->cards_state }}
							</span>
						</a>
					</td>
					<td>
						<a href="{{ route('admin.crawlers.run', $crawler->id) }}">{{ trans('crawlers.run') }}</a>
					</td><td>
						<a href="{{ route('admin.crawlers.edit', $crawler->id) }}">{{ trans('app.edit') }}</a>
					</td>
					<td>
						<form action="{{ route('admin.crawlers.destroy', $crawler->id) }}" method="post">
							{{ method_field('DELETE') }}
							{{ csrf_field() }}
							<input type="submit" value="{{ trans('app.delete') }}" onclick="return confirm('{{ trans('brands.confirm_deletion') }}');" />
						</form>
					</td>
				</tr>
			@endforeach
			</tbody>
		</table>
	</div>
</div>
@endsection