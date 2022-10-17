<template>
  <div>
    <div id="modal-base" class="fixed -inset-0 bg-black bg-opacity-5 flex flex-col justify-center" style=" background-color: rgba(0,0,0,.5);" ></div>
    <div class="fixed top-1/2 left-1/2 bg-white flex flex-col justify-center w-3/5 h-auto rounded-xl p-8 pb-0 -translate-y-2/4 -translate-x-2/4">
      <textarea class="caret-slate-500 border-b resize-none outline-none" placeholder="投稿内容を入力" name="" cols="20" rows="10" maxlength="400"></textarea>
      <div class="text-right py-4">
        <span class="py-2 px-5 bg-blue-400 text-white rounded-full text-sm">投稿</span>  
      </div>
    </div>
  </div>
</template>
