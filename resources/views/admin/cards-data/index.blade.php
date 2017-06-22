@extends('layouts.admin')

@section('title', trans('cards_data.cards_data'))

@section('content')

<div class="row standard-margin-bottom">
	<div class="col-md-12">
		<a href="{{ route('admin.crawlers.show', $crawler) }}" class="btn btn-primary">
			<span class="glyphicon glyphicon-arrow-left"></span> {{ trans('cards_data.back_to_crawler') }}
		</a>
	</div>
</div>

@foreach ($cardsData as $cardData)
<div class="row">
	<div class="col-md-12">
		<div class="panel panel-default">
			<div class="panel-heading" @if (!empty($cardData->card_id) && !empty($cardData->variation_id)) role="button" data-toggle="collapse" data-target="#collapse-{{ $cardData->id }}" aria-controls="collapse-{{ $cardData->id }}" aria-expanded="false" @endif>
				<strong>#{{ $cardData->id }}</strong> <em>{{ $cardData->name }}</em>
			</div>
			<div class="panel-body @if (!empty($cardData->card_id) && !empty($cardData->variation_id)) collapse @endif" id="collapse-{{ $cardData->id }}">
				<dl>
					<dt>{{ trans('cards_data.page_url') }}</dt>
					<dd>
						<a href="{{ $cardData->cardPage->url }}" target="_blank">{{ $cardData->cardPage->url }}</a>
					</dd>

					<dt>{{ trans('cards_data.linked_card') }}</dt>
					<dd>
					@if (!empty($cardData->card))
						<a href="{{ route('admin.cards.show', $cardData->card) }}">{{ $cardData->card->name }}</a>
					@else
						<em>{{ trans('cards_data.no_linked_card') }}</em>
					@endif
					</dd>
					<dt>{{ trans('cards_data.linked_variation') }}</dt>
					<dd>
					@if (!empty($cardData->variation))
						<a href="{{ route('admin.cards.show', $cardData->card) }}">{{ $cardData->variation->name }}</a>
					@else
						<em>{{ trans('cards_data.no_linked_variation') }}</em>
					@endif
					</dd>

					<dt>{{ trans('cards.brand') }}</dt>
					<dd>
					@if (!empty($cardData->brand))
						<a href="{{ route('admin.brands.show', $cardData->brand) }}">{{ $cardData->brand->name }}</a>
					@else
						<em>{{ trans('cards_data.no_linked_brand') }}</em>
					@endif
					</dd>

					<dt>{{ trans('cards.name') }}</dt>
					<dd>{{ $cardData->name }}</dd>

					<dt>{{ trans('cards.description') }}</dt>
					<dd>{!! nl2br(e($cardData->description)) !!}</dd>

					<dt>{{ trans('stores.availability') }}</dt>
					<dd>
						{{ $cardData->in_stock ? trans('stores.in_stock') : trans('stores.sold_out') }}
					</dd>

					<dt>{{ trans('stores.price') }}</dt>
					<dd>${{ $cardData->price }}</dd>

					<dt>{{ trans('app.created_at') }}</dt>
					<dd>{{ $cardData->created_at }}</dd>

					<dt>{{ trans('app.updated_at') }}</dt>
					<dd>{{ $cardData->updated_at }}</dd>

					@if (empty($cardData->card_id))
					<dt>{{ trans('cards_data.potential_matches') }}</dt>
					<dd>
						<table class="table table-condensed table-hover table-striped">
							<thead>
								<th>{{ trans('cards_data.distance') }}</th>
								<th>{{ trans('cards.name') }}</th>
								<th>{{ trans('cards.brand') }}</th>
								<th>{{ trans('cards_data.select_match') }}</th>
							</thead>
							<tbody>
							@foreach ($cardData->potential_matches as $potentialMatch)
								<tr>
									<td>{{ $potentialMatch->total_distance }}</td>
									<td>
										<a href="{{ route('admin.cards.show', $potentialMatch) }}">{{ $potentialMatch->name }}</a>
									</td>
									<td>{{ $potentialMatch->brand->name }}</td>
									<td>
										<form action="{{ route('admin.crawlers.cards-data.update', [$crawler, $cardData]) }}" method="post">
											{{ method_field('PUT') }}
											{{ csrf_field() }}
											<input type="hidden" name="card" value="{{ $potentialMatch->id }}" />

											<input type="submit" value="{{ trans('cards_data.select_match') }}" />
										</form>
									</td>
								</tr>
							@endforeach
							@if (count($cardData->potential_matches) == 0)
								<tr>
									<td colspan="4" class="text-center">{{ trans('cards_data.no_potential_matches') }}</td>
								</tr>
							@endif
								<tr>
									<td colspan="4" class="text-center">
										<form action="{{ route('admin.crawlers.cards-data.new-card', [$crawler, $cardData]) }}" method="post">
											{{ csrf_field() }}
											<input type="submit" value="{{ trans('cards_data.new_card_from_data') }}" />
										</form>
									</td>
								</tr>
							</tbody>
						</table>
					</dd>
					@endif

					@if (empty($cardData->variation_id) && !empty($cardData->card_id))
					<dt>{{ trans('cards_data.potential_variations') }}</dt>
					<dd>
						<table class="table table-condensed table-hover table-striped">
							<thead>
								<th>{{ trans('cards.name') }}</th>
								<th>{{ trans('cards_data.select_match') }}</th>
							</thead>
							<tbody>
							@foreach ($cardData->card->variations as $variation)
								<tr>
									<td>{{ $variation->name }}</td>
									<td>
										<form action="{{ route('admin.crawlers.cards-data.update', [$crawler, $cardData]) }}" method="post">
											{{ method_field('PUT') }}
											{{ csrf_field() }}
											<input type="hidden" name="variation" value="{{ $variation->id }}" />

											<input type="submit" value="{{ trans('cards_data.select_match') }}" />
										</form>
									</td>
								</tr>
							@endforeach
							</tbody>
						</table>
					</dd>
					@endif
				</dl>
			</div>
		</div>
	</div>
</div>
@endforeach

@endsection