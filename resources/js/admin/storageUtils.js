import { supabase } from '../supabase';

const BUCKET = 'ipag-images';

/**
 * Extracts the storage path from a Supabase public URL.
 * e.g. "https://xxx.supabase.co/storage/v1/object/public/ipag-images/artists/123-photo.jpg"
 *   => "artists/123-photo.jpg"
 *
 * Returns null if the URL is not a Supabase storage URL for this bucket
 * (e.g. it's a legacy local /images/... path — safe to skip).
 */
export function storagePathFromUrl(url) {
    if (!url) return null;
    const marker = `/object/public/${BUCKET}/`;
    const idx = url.indexOf(marker);
    if (idx === -1) return null;
    return url.slice(idx + marker.length);
}

/**
 * Deletes a file from Supabase Storage given its public URL.
 * Silently skips if the URL is not a storage URL (e.g. a legacy /images/ path).
 */
export async function deleteFromStorage(url) {
    const path = storagePathFromUrl(url);
    if (!path) return; // not a bucket URL — nothing to delete
    const { error } = await supabase.storage.from(BUCKET).remove([path]);
    if (error) console.warn('[storageUtils] delete failed:', path, error.message);
}

/**
 * Deletes multiple URLs from storage in one call.
 */
export async function deleteManyFromStorage(urls) {
    const paths = urls.map(storagePathFromUrl).filter(Boolean);
    if (!paths.length) return;
    const { error } = await supabase.storage.from(BUCKET).remove(paths);
    if (error) console.warn('[storageUtils] batch delete failed:', error.message);
}
