<div class="row">
	<div class="col-md-12">
		{{ $cards->links() }}
	</div>
</div>

<div class="row cards">
	@foreach ($cards as $card)
	<div class="col-lg-3 col-md-4 col-sm-12 card-container">
		<a href="{{ route('cards.show', $card->id) }}"  class="card">
			<img src="{{ !empty($card->mainBackPicture) ? $card->mainBackPicture->path : '/img/misc/card-back-default.png' }}" alt="" />
			<div class="card-info">
				<h2 class="name">{{ $card->name }}</h2>
			</div>
		</a>
	</div>
	@endforeach
</div>

<div class="row">
	<div class="col-md-12">
		{{ $cards->links() }}
	</div>
</div>
