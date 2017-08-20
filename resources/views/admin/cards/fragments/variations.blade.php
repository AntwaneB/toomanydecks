@foreach ($card->variations as $variation)
	<form action="{{ route('admin.variations.update', $variation->id) }}" method="post">
		{{ method_field('PUT') }}
		{{ csrf_field() }}

		<div class="panel panel-default">
			<div class="panel-heading">
				{{ trans('variations.variation') }}
			</div>
			<div class="panel-body">
				<div class="form-group">
					<label>{{ trans('variations.name') }}</label>
					<input type="text" name="name" value="{{ $variation->name }}" required="required" class="form-control" placeholder="{{ trans('variations.name') }}" />
				</div>

				<div class="form-group">
					<label>{{ trans('variations.description') }}</label>
					<textarea name="description" class="form-control" rows="3" placeholder="{{ trans('variations.description') }}">{{ $variation->description }}</textarea>
				</div>

				<table class="table table-striped table-hover table-condensed vertically-aligned">
					<thead>
						<th>{{ trans('stores.store') }}</th>
						<th>{{ trans('stores.availability') }}</th>
						<th>{{ trans('stores.price') }}</th>
						<th>{{ trans('stores.card_page') }}</th>
						<th>{{ trans('app.delete') }}</th>
					</thead>
					<tbody>
					@foreach ($variation->stores as $variationStore)
						<tr>
							<td>
								<select name="variation_stores[{{ $loop->index }}][store]" class="form-control" required="required">
									@foreach ($stores as $store)
										<option value="{{ $store->id }}" @if ($store->id == $variationStore->id) selected="selected" @endif>{{ $store->name }}</option>
									@endforeach
								</select>
							</td>
							<td class="form-inline">
								<div class="radio">
									<label>
										<input type="radio" name="variation_stores[{{ $loop->index }}][in_stock]" value="1" @if ($variationStore->pivot->in_stock) checked="checked" @endif>
										{{ trans('stores.in_stock') }}
									</label>
								</div>
								<div class="radio">
									<label>
										<input type="radio" name="variation_stores[{{ $loop->index }}][in_stock]" value="0" @if (!$variationStore->pivot->in_stock) checked="checked" @endif>
										{{ trans('stores.sold_out') }}
									</label>
								</div>
							</td>
							<td>
								<div class="input-group">
									<span class="input-group-addon">$</span>
									<input type="text" name="variation_stores[{{ $loop->index }}][price]" class="form-control" value="{{ $variationStore->pivot->price }}" placeholder="{{ trans('stores.price') }}" required="required">
								</div>
							</td>
							<td>
								<input type="text" name="variation_stores[{{ $loop->index }}][url]" value="{{ $variationStore->pivot->url }}" class="form-control" placeholder="{{ trans('stores.card_page') }}" />
							</td>
							<td class="text-center">
								<button type="button" class="close" onclick="if (confirm('{{ trans('variations.confirm_deletion') }}')) { $(this).closest('tr').remove() }"><span aria-hidden="true">&times;</span></button>
							</td>
						</tr>
					@endforeach
					<tr>
						<td colspan="5"><strong>{{ trans('stores.add_new') }} :</strong></td>
					</tr>
					<tr>
						<td>
							<select name="variation_stores[{{ count($variation->stores) }}][store]" class="form-control">
								<option value="" selected="selected">{{ trans('app.select_one') }}</option>
								@foreach ($stores as $store)
									<option value="{{ $store->id }}">{{ $store->name }}</option>
								@endforeach
							</select>
						</td>
						<td class="form-inline">
							<div class="radio">
								<label>
									<input type="radio" name="variation_stores[{{ count($variation->stores) }}][in_stock]" value="1">
									{{ trans('stores.in_stock') }}
								</label>
							</div>
							<div class="radio">
								<label>
									<input type="radio" name="variation_stores[{{ count($variation->stores) }}][in_stock]" value="0">
									{{ trans('stores.sold_out') }}
								</label>
							</div>
						</td>
						<td>
							<div class="input-group">
								<span class="input-group-addon">$</span>
								<input type="text" name="variation_stores[{{ count($variation->stores) }}][price]" class="form-control" placeholder="{{ trans('stores.price') }}">
							</div>
						</td>
						<td>
							<input type="text" name="variation_stores[{{ count($variation->stores) }}][url]" class="form-control" placeholder="{{ trans('stores.card_page') }}" />
						</td>
						<td class="text-center">
							<button type="button" class="close" onclick="if (confirm('{{ trans('variations.confirm_deletion') }}')) { $(this).closest('tr').remove() }"><span aria-hidden="true">&times;</span></button>
						</td>
					</tr>
					</tbody>
				</table>

				<div class="form-group">
					<input type="submit" value="{{ trans('variations.update') }}" class="btn btn-primary" />
				</div>
			</div>
		</div>
	</form>
@endforeach