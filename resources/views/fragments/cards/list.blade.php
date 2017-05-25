<div class="row">
	<div class="col-md-12">
		{{ $cards->links() }}
	</div>
</div>

<div class="row cards">
	@foreach ($cards as $card)
	<div class="col-lg-3 col-md-4 col-sm-12 card-container">
		<a href="{{ route('cards.show', $card->id) }}"  class="card">
			<img src="{{ $card->mainBackPicture->path }}" alt="" />
			<div class="card-info">
				<h2 class="name">{{ $card->name }}</h2>
			</div>
		</a>
	</div>
	@endforeach
</div>
